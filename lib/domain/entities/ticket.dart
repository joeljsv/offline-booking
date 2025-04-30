import 'package:booking/core/enums/ticket_enums.dart';

class Ticket {
  final String id;
  final String passengerName;
  final DateTime journeyDate;
  final int distanceKm;
  final TicketClass ticketClass;
  final double amount;
  final bool isCancelled;
  final TicketStatus status;

  Ticket({
    required this.id,
    required this.passengerName,
    required this.journeyDate,
    required this.distanceKm,
    required this.ticketClass,
    required this.amount,
    this.isCancelled = false,
    this.status = TicketStatus.booked,
  });

  Ticket copyWith({
    String? id,
    String? passengerName,
    DateTime? journeyDate,
    int? distanceKm,
    TicketClass? ticketClass,
    double? amount,
    bool? isCancelled,
    TicketStatus? status,
  }) {
    return Ticket(
      id: id ?? this.id,
      passengerName: passengerName ?? this.passengerName,
      journeyDate: journeyDate ?? this.journeyDate,
      distanceKm: distanceKm ?? this.distanceKm,
      ticketClass: ticketClass ?? this.ticketClass,
      amount: amount ?? this.amount,
      isCancelled: isCancelled ?? this.isCancelled,
      status: status ?? this.status,
    );
  }
}
