import 'package:flutter/material.dart';
import 'package:booking/core/constants/strings.dart';
import 'package:booking/core/utils/date_formatter.dart';

class TicketCard extends StatelessWidget {
  final String id;
  final String passengerName;
  final String ticketClass;
  final double amount;
  final DateTime journeyDate;
  final String status;
  final VoidCallback? onCancel;

  const TicketCard({
    super.key,
    required this.id,
    required this.passengerName,
    required this.ticketClass,
    required this.amount,
    required this.journeyDate,
    required this.status,
    this.onCancel,
  });

  Color _getStatusColor(String status) {
    return switch (status.toLowerCase()) {
      'booked' => Colors.blue.shade700,
      'cancelled' => Colors.red.shade600,
      'completed' => Colors.green.shade600,
      _ => Colors.grey,
    };
  }

  IconData _getClassIcon(String ticketClass) {
    return switch (ticketClass.toLowerCase()) {
      'general' => Icons.event_seat,
      'cc' => Icons.directions_bus,
      'sleeper' => Icons.airline_seat_individual_suite,
      'ac' => Icons.ac_unit,
      _ => Icons.confirmation_number,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(status);
    final classIcon = _getClassIcon(ticketClass);
    final formattedDate = DateFormats.journeyDateTime.format(journeyDate);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Column(
        children: [
          // ✨ Top Ticket Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(classIcon, size: 24, color: Colors.indigo),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    passengerName,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                if (onCancel != null)
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    tooltip: AppStrings.cancel,
                    onPressed: onCancel,
                  )
              ],
            ),
          ),

          const Divider(height: 1),

          // 🧾 Bottom Details
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow("Ticket ID", "#$id", theme),
                _infoRow("Class", ticketClass.toUpperCase(), theme),
                _infoRow("Amount", "₹${amount.toInt()}", theme),
                _infoRow("Journey", formattedDate, theme),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      status.toUpperCase(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text("$label:", style: theme.textTheme.bodySmall)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
