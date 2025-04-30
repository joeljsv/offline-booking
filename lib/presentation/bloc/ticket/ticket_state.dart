import 'package:equatable/equatable.dart';
import '../../../domain/entities/ticket.dart';

abstract class TicketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final List<Ticket> allTickets;
  final List<Ticket> filteredTickets;
  final double balance;

  TicketLoaded({
    required this.allTickets,
    required this.filteredTickets,
    required this.balance,
  });

  @override
  List<Object?> get props => [allTickets, filteredTickets, balance];
}


class TicketOperationSuccess extends TicketState {}

class TicketOperationFailure extends TicketState {
  final String error;

  TicketOperationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
