import 'package:booking/data/repositories/ticket_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:booking/data/models/ticket_model.dart';
import 'package:booking/data/repositories_impl/ticket_repository_impl.dart';
import 'package:booking/domain/usecases/book_ticket.dart';
import 'package:booking/domain/usecases/cancel_ticket.dart';
import 'package:booking/domain/usecases/get_all_tickets.dart';
import 'package:booking/presentation/bloc/ticket/ticket_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Hive setup
  await Hive.initFlutter();
  Hive.registerAdapter(TicketModelAdapter());
  final ticketBox = await Hive.openBox<TicketModel>('tickets');
  final settingsBox = await Hive.openBox('settings');

  // Repository
  sl.registerLazySingleton<TicketRepository>(() => TicketRepositoryImpl(ticketBox));

  // ✅ Register use cases
  sl.registerLazySingleton(() => BookTicket(sl()));
  sl.registerLazySingleton(() => CancelTicket(sl()));
  sl.registerLazySingleton(() => GetAllTickets(sl()));

  // BLoC
  sl.registerFactory(() => TicketBloc(
        bookTicket: sl(),
        getAllTickets: sl(),
        cancelTicket: sl(),
        settingsBox: settingsBox,
      ));
}
