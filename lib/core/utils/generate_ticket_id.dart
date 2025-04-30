import 'dart:math';
import 'package:intl/intl.dart';

String generateTicketId() {
  final now = DateTime.now();
  final date = DateFormat('yyMMdd').format(now); // e.g., 240430
  final time = DateFormat('HHmmss').format(now); // e.g., 143522

  final random = Random();
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final randomCode = List.generate(3, (_) => chars[random.nextInt(chars.length)]).join();

  return 'TKT-$date-$time-$randomCode';
}
