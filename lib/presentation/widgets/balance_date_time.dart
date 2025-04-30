import 'package:flutter/material.dart';
import 'package:booking/core/constants/strings.dart';
import 'package:booking/core/utils/date_formatter.dart';

class BalanceDateTimeWidget extends StatelessWidget {
  final double balance;

  const BalanceDateTimeWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDateTime = DateFormats.fullDateTime.format(now);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Balance Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.balance, style: theme.textTheme.bodySmall),
              const SizedBox(height: 4),
              Text(
                '₹${balance.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),

          // Date & Time Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppStrings.currentDateTime,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Text(
                formattedDateTime,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
