import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../modules/auth/presentation/login_screen/login_view.dart';
import 'app_routers.dart';
import 'not_found_screen.dart';

GoRouter goRouter() {
  final talker = Talker();
  final defaultLocation = AppRoutes.login.initLocation;
  const restorationScopeId = 'app_router';
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    initialLocation: defaultLocation,
    restorationScopeId: restorationScopeId,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    observers: [TalkerRouteObserver(talker)],
    routes: [
      GoRoute(
        path: AppRoutes.login.initLocation,
        name: AppRoutes.login.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.notFound.initLocation,
        name: AppRoutes.notFound.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const NotFoundScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SizeTransition(sizeFactor: animation, child: child);
    },
  );
}
