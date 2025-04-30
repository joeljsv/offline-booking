import 'package:booking/data/repositories/ticket_repository.dart';
import 'package:booking/domain/entities/ticket.dart';

class GetAllTickets {
  final TicketRepository repository;
  GetAllTickets(this.repository);
  Future<List<Ticket>> call() => repository.getAllTickets();
}