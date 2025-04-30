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
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: BookTicketRoute.page),
        AutoRoute(page: CancelTicketRoute.page),
      ];
}
