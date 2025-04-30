// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BookTicketRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BookTicketPage(),
      );
    },
    CancelTicketRoute.name: (routeData) {
      final args = routeData.argsAs<CancelTicketRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CancelTicketPage(
          key: args.key,
          ticket: args.ticket,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
  };
}

/// generated route for
/// [BookTicketPage]
class BookTicketRoute extends PageRouteInfo<void> {
  const BookTicketRoute({List<PageRouteInfo>? children})
      : super(
          BookTicketRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookTicketRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CancelTicketPage]
class CancelTicketRoute extends PageRouteInfo<CancelTicketRouteArgs> {
  CancelTicketRoute({
    Key? key,
    required Ticket ticket,
    List<PageRouteInfo>? children,
  }) : super(
          CancelTicketRoute.name,
          args: CancelTicketRouteArgs(
            key: key,
            ticket: ticket,
          ),
          initialChildren: children,
        );

  static const String name = 'CancelTicketRoute';

  static const PageInfo<CancelTicketRouteArgs> page =
      PageInfo<CancelTicketRouteArgs>(name);
}

class CancelTicketRouteArgs {
  const CancelTicketRouteArgs({
    this.key,
    required this.ticket,
  });

  final Key? key;

  final Ticket ticket;

  @override
  String toString() {
    return 'CancelTicketRouteArgs{key: $key, ticket: $ticket}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
