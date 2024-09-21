import 'package:attendance_app/src/views/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final GoRoute studentRoutes = GoRoute(
  path: '/student',
  builder: (context, state) => const StudentHome(),
  routes: [
    GoRoute(
      path: 'attendance', // Nested route
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const AttendanceStudent(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide transition from right to left
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      },
    ),

  ],
);
