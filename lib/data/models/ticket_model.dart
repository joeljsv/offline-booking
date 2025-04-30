
import 'package:booking/core/enums/ticket_enums.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/ticket.dart';

part 'ticket_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class TicketModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String passengerName;

  @HiveField(2)
  final DateTime journeyDate;

  @HiveField(3)
  final int distanceKm;

  @HiveField(4)
  final int ticketClass; // stored as int for Hive

  @HiveField(5)
  final double amount;

  @HiveField(6)
  final bool isCancelled;

  TicketModel({
    required this.id,
    required this.passengerName,
    required this.journeyDate,
    required this.distanceKm,
    required this.ticketClass,
    required this.amount,
    required this.isCancelled,
  });

  // 🔁 Convert to domain entity
  Ticket toEntity() {
    return Ticket(
      id: id,
      passengerName: passengerName,
      journeyDate: journeyDate,
      distanceKm: distanceKm,
      ticketClass: TicketClass.values[ticketClass],
      amount: amount,
      isCancelled: isCancelled,
    );
  }

  // 🔁 Create model from domain entity
  factory TicketModel.fromEntity(Ticket ticket) {
    return TicketModel(
      id: ticket.id,
      passengerName: ticket.passengerName,
      journeyDate: ticket.journeyDate,
      distanceKm: ticket.distanceKm,
      ticketClass: ticket.ticketClass.index,
      amount: ticket.amount,
      isCancelled: ticket.isCancelled,
    );
  }

  // 🛠️ copyWith method
  TicketModel copyWith({
    String? id,
    String? passengerName,
    DateTime? journeyDate,
    int? distanceKm,
    int? ticketClass,
    double? amount,
    bool? isCancelled,
  }) {
    return TicketModel(
      id: id ?? this.id,
      passengerName: passengerName ?? this.passengerName,
      journeyDate: journeyDate ?? this.journeyDate,
      distanceKm: distanceKm ?? this.distanceKm,
      ticketClass: ticketClass ?? this.ticketClass,
      amount: amount ?? this.amount,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}

