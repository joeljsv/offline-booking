
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// This is the initial route of the app.
        AutoRoute(page: HomeRoute.page, initial: true),

        /// Defines the route for the `BookTicketPage`.
        AutoRoute(page: BookTicketRoute.page),

        /// Defines the route for the `CancelTicketPage`.
        AutoRoute(page: CancelTicketRoute.page),
      ];
}
