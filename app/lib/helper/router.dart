import 'package:app/screens/screens.dart';
import 'package:go_router/go_router.dart';

abstract class ROUTES {
  static const dashboard = RouteParam(name: 'Dashboard', path: '/');
}

final appRouter = GoRouter(
  routes: [
    GoRoute.fromRouteParam(
      param: ROUTES.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);
