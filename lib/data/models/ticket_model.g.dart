// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketModelAdapter extends TypeAdapter<TicketModel> {
  @override
  final int typeId = 0;

  @override
  TicketModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketModel(
      id: fields[0] as String,
      passengerName: fields[1] as String,
      journeyDate: fields[2] as DateTime,
      distanceKm: fields[3] as int,
      ticketClass: fields[4] as int,
      amount: fields[5] as double,
      isCancelled: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TicketModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.passengerName)
      ..writeByte(2)
      ..write(obj.journeyDate)
      ..writeByte(3)
      ..write(obj.distanceKm)
      ..writeByte(4)
      ..write(obj.ticketClass)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.isCancelled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: json['id'] as String,
      passengerName: json['passengerName'] as String,
      journeyDate: DateTime.parse(json['journeyDate'] as String),
      distanceKm: (json['distanceKm'] as num).toInt(),
      ticketClass: (json['ticketClass'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      isCancelled: json['isCancelled'] as bool,
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'passengerName': instance.passengerName,
      'journeyDate': instance.journeyDate.toIso8601String(),
      'distanceKm': instance.distanceKm,
      'ticketClass': instance.ticketClass,
      'amount': instance.amount,
      'isCancelled': instance.isCancelled,
    };
