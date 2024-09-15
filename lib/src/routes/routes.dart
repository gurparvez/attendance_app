import 'package:attendance_app/src/views/screens/screens.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/student",
      builder: (context, state) => const HomeStudent(),
    ),
  ],
);
