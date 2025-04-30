import 'package:booking/data/repositories/ticket_repository.dart';
import 'package:booking/domain/entities/ticket.dart';

class BookTicket {
  final TicketRepository repository;
  BookTicket(this.repository);

  Future<void> call(Ticket ticket) => repository.bookTicket(ticket);
}