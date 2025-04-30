import 'package:booking/core/enums/ticket_enums.dart';
import 'package:booking/core/utils/refund_calculation.dart';
import 'package:booking/data/services/local_notification_service.dart';
import 'package:booking/domain/entities/ticket.dart';
import 'package:booking/domain/usecases/book_ticket.dart';
import 'package:booking/domain/usecases/cancel_ticket.dart';
import 'package:booking/domain/usecases/get_all_tickets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'ticket_event.dart';
import 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final BookTicket bookTicket;
  final GetAllTickets getAllTickets;
  final CancelTicket cancelTicket;
  final Box settingsBox;
  late double _balance;

  List<Ticket> _allTickets = [];

  TicketBloc({
    required this.bookTicket,
    required this.getAllTickets,
    required this.cancelTicket,
    required this.settingsBox,
  }) : super(TicketInitial()) {
    on<LoadTickets>(_onLoadTickets);
    on<BookTicketEvent>(_onBookTicket);
    on<CancelTicketEvent>(_onCancelTicket);
    on<FilterTicketsEvent>(_onFilterTickets);
    _balance = settingsBox.get('balance', defaultValue: 10000.0);
  }

  Future<void> _onLoadTickets(
    LoadTickets event,
    Emitter<TicketState> emit,
  ) async {
    emit(TicketLoading());
    try {
      _allTickets = await getAllTickets();

      _updateTicketStatuses();
      _sortTicketsByJourneyDate();

      emit(TicketLoaded(
        allTickets: _allTickets,
        filteredTickets: _allTickets,
        balance: _balance,
      ));
    } catch (e) {
      emit(TicketOperationFailure(e.toString()));
    }
  }

  Future<void> _onBookTicket(
    BookTicketEvent event,
    Emitter<TicketState> emit,
  ) async {
    try {
      await bookTicket(event.ticket);
      await _updateBalance(_balance - event.ticket.amount);

      await NotificationService.show(
        title: 'Ticket Booked: ${event.ticket.id}',
        body: 'Amount: ₹${event.ticket.amount.toInt()} | Balance: ₹${_balance.toInt()}',
      );

      add(LoadTickets());
    } catch (e) {
      emit(TicketOperationFailure(e.toString()));
    }
  }

  Future<void> _onCancelTicket(
    CancelTicketEvent event,
    Emitter<TicketState> emit,
  ) async {
    try {
      final ticket = _allTickets.firstWhere((t) => t.id == event.ticketId);

      final refund = calculateRefund(ticket);
      await _updateBalance(_balance + refund);

      await cancelTicket(event.ticketId, event.now);

      await NotificationService.show(
        title: 'Ticket Cancelled: ${ticket.id}',
        body: 'Refund: ₹${refund.toInt()} | Balance: ₹${_balance.toInt()}',
      );

      add(LoadTickets());
    } catch (e) {
      emit(TicketOperationFailure(e.toString()));
    }
  }

 void _onFilterTickets(FilterTicketsEvent event, Emitter<TicketState> emit) {
  final now = DateTime.now();

  _updateTicketStatuses();
  _sortTicketsByJourneyDate();

  final filtered = _allTickets.where((ticket) {
    final matchesSearch = ticket.passengerName.toLowerCase().contains(
      event.searchQuery.toLowerCase(),
    );

    final matchesDate = (event.filterStatus == TicketFilterStatus.upcoming ||
                         event.filterStatus == TicketFilterStatus.completed)
        ? ticket.journeyDate.year == event.selectedDate.year &&
            ticket.journeyDate.month == event.selectedDate.month &&
            ticket.journeyDate.day == event.selectedDate.day
        : true;

    final ticketStatus = _getStatus(ticket, now);

    final matchesStatus = event.filterStatus == TicketFilterStatus.all ||
        event.filterStatus == ticketStatus;

    return matchesSearch && matchesDate && matchesStatus;
  }).toList();

  emit(TicketLoaded(
    allTickets: _allTickets,
    filteredTickets: filtered,
    balance: _balance,
  ));
}


  Future<void> _updateBalance(double value) async {
    _balance = value;
    await settingsBox.put('balance', _balance);
  }

  void _updateTicketStatuses() {
    final now = DateTime.now();
    _allTickets = _allTickets.map((ticket) {
      final isCompleted = !ticket.isCancelled && ticket.journeyDate.isBefore(now);
      if (isCompleted && ticket.status != TicketStatus.completed) {
        return ticket.copyWith(status: TicketStatus.completed);
      }
      // If the ticket is cancelled, set its status to cancelled
      if (ticket.isCancelled && ticket.status != TicketStatus.cancelled) {
        return ticket.copyWith(status: TicketStatus.cancelled);
      }
      return ticket;
    }).toList();
  }

  void _sortTicketsByJourneyDate() {
    _allTickets.sort((a, b) => a.journeyDate.compareTo(b.journeyDate));
  }

  TicketFilterStatus _getStatus(Ticket ticket, DateTime now) {
    if (ticket.isCancelled) return TicketFilterStatus.cancelled;
    if (ticket.journeyDate.isAfter(now)) return TicketFilterStatus.upcoming;
    return TicketFilterStatus.completed;
  }
}
