import 'package:attendance_app/src/routes/student.route.dart';
import 'package:attendance_app/src/routes/teacher.route.dart';
import 'package:attendance_app/src/views/screens/screens.dart';
import 'package:attendance_app/src/views/screens/welcome.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
    studentRoutes,
    teacherRoutes,
  ],
);
