import 'package:booking/domain/entities/ticket.dart';

abstract class TicketRepository {
  Future<void> bookTicket(Ticket ticket);
  Future<List<Ticket>> getAllTickets();
  Future<void> cancelTicket(String ticketId, DateTime now);
}
