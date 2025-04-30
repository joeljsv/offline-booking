
  import 'package:booking/core/enums/ticket_enums.dart';
  /// Calculates the fare for a ticket based on the distance and ticket class.
  ///
  /// - Parameters:
  ///   - distance: The distance of the journey in kilometers.
  ///   - classType: The ticket class, which determines the base rate and minimum fare.
  ///
  /// - Returns: The calculated fare as a double.
double calculateFare(int distance, TicketClass classType) {
    final baseRate = switch (classType) {
      TicketClass.general => 10,
      TicketClass.cc => 20,
      TicketClass.sleeper => 30,
      TicketClass.ac => 50,
    };
    final minFare = switch (classType) {
      TicketClass.general => 50,
      TicketClass.cc => 100,
      TicketClass.sleeper => 150,
      TicketClass.ac => 250,
    };

    return (distance * baseRate).clamp(minFare, double.infinity).toDouble();
  }