import 'package:auto_route/auto_route.dart';
import 'package:booking/domain/entities/ticket.dart';
import 'package:booking/presentation/pages/home_page.dart';
import 'package:booking/presentation/pages/book_ticket_page.dart';
import 'package:booking/presentation/pages/cancel_ticket_page.dart';
import 'package:flutter/foundation.dart';

part 'app_router.gr.dart'; 

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// Defines the route for the `HomePage`. This is the initial route of the app.
        AutoRoute(page: HomeRoute.page, initial: true),

        /// Defines the route for the `BookTicketPage`.
        AutoRoute(page: BookTicketRoute.page),

        /// Defines the route for the `CancelTicketPage`.
        AutoRoute(page: CancelTicketRoute.page),      ];
}
