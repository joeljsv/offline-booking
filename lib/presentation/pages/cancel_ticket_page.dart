import 'package:auto_route/auto_route.dart';
import 'package:booking/core/utils/refund_calculation.dart';
import 'package:booking/domain/entities/ticket.dart';
import 'package:booking/presentation/bloc/ticket/ticket_bloc.dart';
import 'package:booking/presentation/bloc/ticket/ticket_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage()
class CancelTicketPage extends StatefulWidget {
  final Ticket ticket;

  const CancelTicketPage({super.key, required this.ticket});

  @override
  State<CancelTicketPage> createState() => _CancelTicketPageState();
}

class _CancelTicketPageState extends State<CancelTicketPage> {
  late double refundAmount;

  @override
  void initState() {
    super.initState();
    refundAmount = calculateRefund(widget.ticket);
  }

  void _onConfirmCancel(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Confirm Cancellation'),
            content: Text(
              'Are you sure you want to cancel this ticket?\nRefund: ₹${refundAmount.toStringAsFixed(2)}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  context.read<TicketBloc>().add(
                    CancelTicketEvent(widget.ticket.id, DateTime.now()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ticket cancelled successfully!"),
                    ),
                  );
                  Navigator.of(context).pop(); // Go back
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Yes, Cancel'),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool bold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("Cancel Ticket")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Passenger Name', ticket.passengerName),
                  _buildDetailRow(
                    'Journey Date',
                    DateFormat('yyyy-MM-dd – kk:mm').format(ticket.journeyDate),
                  ),
                  _buildDetailRow(
                    'Ticket Class',
                    ticket.ticketClass.name.toUpperCase(),
                  ),
                  _buildDetailRow(
                    'Total Paid',
                    '₹${ticket.amount.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    'Estimated Refund',
                    '₹${refundAmount.toStringAsFixed(2)}',
                    bold: true,
                    valueColor: Colors.green.shade700,
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _onConfirmCancel(context),
                icon: const Icon(Icons.cancel),
                label: const Text('Cancel Ticket'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
