import 'package:auto_route/auto_route.dart';
import 'package:booking/core/constants/strings.dart';
import 'package:booking/presentation/bloc/ticket/ticket_bloc.dart';
import 'package:booking/presentation/bloc/ticket/ticket_event.dart';
import 'package:booking/presentation/bloc/ticket/ticket_state.dart';
import 'package:booking/presentation/routes/app_router.dart';
import 'package:booking/presentation/widgets/balance_date_time.dart';
import 'package:booking/presentation/widgets/ticket_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(LoadTickets());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🟦 Balance Widget
          BlocBuilder<TicketBloc, TicketState>(
            builder: (context, state) {
              final balance = state is TicketLoaded ? state.balance : 10000.0;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: BalanceDateTimeWidget(balance: balance),
              );
            },
          ),


          // 🧭 Ticket List
          Expanded(
            child: BlocBuilder<TicketBloc, TicketState>(
              builder: (context, state) {
                if (state is TicketLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TicketLoaded) {
                  return TicketListWidget(
                    tickets: state.filteredTickets,
                    selectedDate: selectedDate,
                  );
                } else if (state is TicketOperationFailure) {
                  return Center(child: Text('${AppStrings.error}: ${state.error}'));
                }
                return const Center(child: Text(AppStrings.noTicketsFound));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushRoute(const BookTicketRoute()),
        label: const Text(AppStrings.bookTicket),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
