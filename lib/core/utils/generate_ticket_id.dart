/// Generates a unique ticket ID in the format `TKT-yyMMdd-HHmmss-XXX`.
/// 
/// The ticket ID consists of:
/// - A prefix `TKT-`.
/// - The current date in the format `yyMMdd` (year, month, day).
/// - The current time in the format `HHmmss` (hour, minute, second).
/// - A random 3-character alphanumeric code.
/// 
/// The random code is generated using uppercase letters (A-Z) and digits (0-9).
/// 
/// Returns:
/// A string representing the unique ticket ID.
import 'dart:math';
import 'package:intl/intl.dart';

String generateTicketId() {
  final now = DateTime.now();
  final date = DateFormat('yyMMdd').format(now); 
  final time = DateFormat('HHmmss').format(now); 

  final random = Random();
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final randomCode = List.generate(3, (_) => chars[random.nextInt(chars.length)]).join();

  return 'TKT-$date-$time-$randomCode';
}
