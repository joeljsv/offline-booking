import 'package:auto_route/auto_route.dart';
import 'package:booking/core/constants/strings.dart';
import 'package:booking/core/enums/ticket_enums.dart';
import 'package:booking/domain/entities/ticket.dart';
import 'package:booking/presentation/bloc/ticket/ticket_bloc.dart';
import 'package:booking/presentation/bloc/ticket/ticket_event.dart';
import 'package:booking/presentation/bloc/ticket/ticket_state.dart';
import 'package:booking/presentation/routes/app_router.dart';
import 'package:booking/presentation/widgets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketListWidget extends StatefulWidget {
  final List<Ticket> tickets;
  final DateTime selectedDate;

  const TicketListWidget({
    super.key,
    required this.tickets,
    required this.selectedDate,
  });

  @override
  State<TicketListWidget> createState() => _TicketListWidgetState();
}

class _TicketListWidgetState extends State<TicketListWidget> {
  String searchQuery = '';
  TicketFilterStatus filterStatus = TicketFilterStatus.all;

  void _dispatchFilter() {
    context.read<TicketBloc>().add(
      FilterTicketsEvent(
        searchQuery: searchQuery,
        filterStatus: filterStatus,
        selectedDate: widget.selectedDate,
      ),
    );
  }

  Widget _buildResponsiveSearchFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          final spacing = isWide ? 12.0 : 10.0;

          return isWide
              ? Row(
                  children: [
                    Expanded(child: _buildSearchField()),
                    SizedBox(width: spacing),
                    Expanded(child: _buildFilterDropdown()),
                  ],
                )
              : Column(
                  children: [
                    _buildSearchField(),
                    SizedBox(height: 20),
                    _buildFilterDropdown(),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        labelText: AppStrings.searchPlaceholder,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (value) {
        setState(() => searchQuery = value);
        _dispatchFilter();
      },
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButtonFormField<TicketFilterStatus>(
      decoration: InputDecoration(
        labelText: AppStrings.filterStatusLabel,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      value: filterStatus,
      onChanged: (newValue) {
        if (newValue != null) {
          setState(() => filterStatus = newValue);
          _dispatchFilter();
        }
      },
      items: TicketFilterStatus.values.map((status) {
        final label = status.name[0].toUpperCase() + status.name.substring(1);
        return DropdownMenuItem(value: status, child: Text(label));
      }).toList(),
    );
  }

  Widget _buildTicketList() {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        if (state is TicketLoaded) {
          if (state.filteredTickets.isEmpty) {
            return const Center(child: Text(AppStrings.noTicketsFound));
          }

          return ListView.separated(
            itemCount: state.filteredTickets.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, index) {
              final ticket = state.filteredTickets[index];
              return TicketCard(
                id: ticket.id,
                passengerName: ticket.passengerName,
                ticketClass: ticket.ticketClass.name,
                amount: ticket.amount,
                journeyDate: ticket.journeyDate,
                status: ticket.status.name,
                onCancel: (ticket.status == TicketStatus.booked && !ticket.isCancelled)
                    ? () => context.pushRoute(CancelTicketRoute(ticket: ticket))
                    : null,
              );
            },
          );
        } else if (state is TicketLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TicketOperationFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return const Center(child: Text(AppStrings.noTicketsFound));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildResponsiveSearchFilter(context),
        Expanded(child: _buildTicketList()),
      ],
    );
  }
}
