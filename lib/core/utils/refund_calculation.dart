import 'package:booking/core/enums/ticket_enums.dart';
import 'package:booking/domain/entities/ticket.dart';

double calculateRefund(Ticket ticket) {
  final now = DateTime.now();
  final hoursDiff = ticket.journeyDate.difference(now).inHours;

  int basePercent = 0;
  if (hoursDiff >= 24 * 7) {
    basePercent = 100;
  } else if (hoursDiff >= 24 * 2) {
    basePercent = 80;
  } else if (hoursDiff >= 24) {
    basePercent = 50;
  } else if (hoursDiff >= 2) {
    basePercent = 0;
  }

  final rateDeduction = switch (ticket.ticketClass) {
    TicketClass.general => 0,
    TicketClass.cc => 5,
    TicketClass.sleeper => 10,
    TicketClass.ac => 15,
  };

  final refundRate = ((basePercent - rateDeduction).clamp(0, 100)) / 100;
  return (ticket.amount * refundRate).toDouble();
}
