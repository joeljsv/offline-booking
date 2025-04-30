import 'package:auto_route/auto_route.dart';
import 'package:booking/core/enums/ticket_enums.dart';
import 'package:booking/core/utils/date_formatter.dart';
import 'package:booking/core/utils/generate_ticket_id.dart';
import 'package:booking/core/utils/ticket_rate.dart';
import 'package:booking/domain/entities/ticket.dart';
import 'package:booking/presentation/bloc/ticket/ticket_bloc.dart';
import 'package:booking/presentation/bloc/ticket/ticket_event.dart';
import 'package:booking/presentation/bloc/ticket/ticket_state.dart';
import 'package:booking/presentation/widgets/balance_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BookTicketPage extends StatefulWidget {
  const BookTicketPage({super.key});

  @override
  State<BookTicketPage> createState() => _BookTicketPageState();
}

class _BookTicketPageState extends State<BookTicketPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _distanceController = TextEditingController();

  final List<String> _classes = ['General', 'CC', 'Sleeper', 'AC'];
  final DateTime bookingDateTime = DateTime.now();

  String? _selectedClass;
  DateTime? _journeyDateTime;
  double _calculatedFare = 0;

  void _updateFare() {
    final distance = int.tryParse(_distanceController.text.trim());
    if (distance == null || _selectedClass == null) return;

    final classType = TicketClass.values[_classes.indexOf(_selectedClass!)];
    setState(() {
      _calculatedFare = calculateFare(distance, classType);
    });
  }

  void _submit(double currentBalance) {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_calculatedFare > currentBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Insufficient balance! ₹${_calculatedFare.toInt()} needed.',
          ),
        ),
      );
      return;
    }

    final ticket = Ticket(
      id: generateTicketId(),
      passengerName: _nameController.text.trim(),
      distanceKm: int.parse(_distanceController.text.trim()),
      journeyDate: _journeyDateTime!,
      ticketClass: TicketClass.values[_classes.indexOf(_selectedClass!)],
      amount: _calculatedFare,
    );

    context.read<TicketBloc>().add(BookTicketEvent(ticket));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ticket booked successfully!')),
    );
    AutoRouter.of(context).back();
  }

  Future<void> _pickJourneyDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: bookingDateTime.add(const Duration(days: 1)),
      firstDate: bookingDateTime,
      lastDate: DateTime(2100),
    );
    if (!mounted || date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (!mounted || time == null) return;

    setState(() {
      _journeyDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Book Ticket')),
      body: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          final balance = (state is TicketLoaded) ? state.balance : 10000.0;
          final hasEnoughBalance = _calculatedFare <= balance;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  BalanceDateTimeWidget(balance: balance),
                  if (_calculatedFare > 0)
                   ...[
                    SizedBox(
                      height: 20,
                    ),
                     _buildCard([
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          'Estimated Fare: ₹${_calculatedFare.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: hasEnoughBalance ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ]),
                   ],

                  const SizedBox(height: 12),

                  _buildCard([
                    _formField(
                      label: 'Passenger Name',
                      controller: _nameController,
                      validator: (v) => v!.isEmpty ? 'Enter name' : null,
                    ),
                    const SizedBox(height: 12),
                    _formField(
                      label: 'Distance (km)',
                      controller: _distanceController,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _updateFare(),
                      validator: (v) {
                        final val = int.tryParse(v ?? '');
                        return (val == null || val <= 0)
                            ? 'Enter valid distance'
                            : null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedClass,
                      decoration: const InputDecoration(
                        labelText: 'Ticket Class',
                      ),
                      items:
                          _classes
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: (v) {
                        setState(() => _selectedClass = v);
                        _updateFare();
                      },
                      validator: (v) => v == null ? 'Select class' : null,
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        _journeyDateTime == null
                            ? 'Select Journey Date & Time'
                            : DateFormats.journeyDateTime.format(
                              _journeyDateTime!,
                            ),
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: _pickJourneyDateTime,
                    ),
                    if (_journeyDateTime != null &&
                        _journeyDateTime!.isBefore(bookingDateTime))
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Journey time must be after booking time!',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ]),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed:
                          (_journeyDateTime == null ||
                                  _journeyDateTime!.isBefore(bookingDateTime) ||
                                  !hasEnoughBalance)
                              ? null
                              : () => _submit(balance),
                      child: const Text('Book Ticket',style:  TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _formField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }


  Widget _buildCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
