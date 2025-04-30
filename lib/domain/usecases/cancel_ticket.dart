import 'package:booking/data/repositories/ticket_repository.dart';

class CancelTicket {
  final TicketRepository repository;
  CancelTicket(this.repository);
  Future<void> call(String ticketId, DateTime now) async {
    await repository.cancelTicket(ticketId, now);
  }
}