import 'package:booking/data/repositories/ticket_repository.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/ticket.dart';
import '../models/ticket_model.dart';

class TicketRepositoryImpl implements TicketRepository {
  final Box<TicketModel> ticketBox;

  TicketRepositoryImpl(this.ticketBox);

  @override
  Future<void> bookTicket(Ticket ticket) async {
    final ticketModel = TicketModel.fromEntity(ticket);
    await ticketBox.put(ticket.id, ticketModel);
  }

  @override
  Future<List<Ticket>> getAllTickets() async {
    return ticketBox.values.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> cancelTicket(String ticketId, DateTime now) async {
    final ticket = ticketBox.get(ticketId);
    if (ticket != null) {
      ticketBox.put(ticketId, ticket.copyWith(
        isCancelled: true,
        
        // optionally refund logic here
      ));
    }
  }
}
