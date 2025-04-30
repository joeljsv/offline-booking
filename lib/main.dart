import 'package:booking/data/services/local_notification_service.dart';
import 'package:booking/presentation/bloc/ticket/ticket_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;
import 'presentation/bloc/ticket/ticket_bloc.dart';
import 'presentation/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init(); 
  await NotificationService.init(); 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter(); 

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TicketBloc>()..add(LoadTickets()),
      child: MaterialApp.router(
        title: 'Ticket Booking',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: _appRouter.config(), 
      ),
    );
  }
}
