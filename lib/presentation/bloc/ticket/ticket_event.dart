import 'package:booking/core/enums/ticket_enums.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/ticket.dart';

abstract class TicketEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTickets extends TicketEvent {}

class BookTicketEvent extends TicketEvent {
  final Ticket ticket;

  BookTicketEvent(this.ticket);

  @override
  List<Object?> get props => [ticket];
}

class CancelTicketEvent extends TicketEvent {
  final String ticketId;
  final DateTime now;

  CancelTicketEvent(this.ticketId, this.now);

  @override
  List<Object?> get props => [ticketId, now];
}

class FilterTicketsEvent extends TicketEvent {
  final String searchQuery;
  final TicketFilterStatus filterStatus;
  final DateTime selectedDate;

  FilterTicketsEvent({
    this.searchQuery = '',
    this.filterStatus = TicketFilterStatus.all,
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [searchQuery, filterStatus, selectedDate];
}

