import 'package:attendance_app/src/models/subject.student.model.dart';
import 'package:attendance_app/src/views/screens/screens.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final GoRoute studentRoutes = GoRoute(
  path: '/student',
  builder: (context, state) => const StudentHome(),
  routes: [
    GoRoute(
      path: 'attendance/:subjectId', // Nested route
      pageBuilder: (context, state) {
        final id = state.pathParameters['subjectId']!;
        final subject = state.extra as SubjectStudentModel;

        return CustomTransitionPage(
          key: state.pageKey,
          child: AttendanceStudent(subjectId: id, subject: subject),
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
    GoRoute(
      path: "bluetooth",
      pageBuilder: (context, state) {
        final subject = state.extra as SubjectStudentModel;

        return CustomTransitionPage(
          child: Bluetooth(subject: subject),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide transition from bottom-right to center
            const begin = Offset(1.0, 1.0); // Bottom-right corner
            const end = Offset.zero; // Center of the screen
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
      routes: [
        GoRoute(
          path: "error",
          builder: (context, state) => FullScreenError(
            message: state.extra as String,
            onTryAgain: () {
              context.go("/student/bluetooth");
            },
          ),
        ),
      ],
    )
  ],
);
