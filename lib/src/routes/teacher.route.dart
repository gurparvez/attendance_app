import 'package:attendance_app/src/views/screens/teacher/home/teacher.dart';
import 'package:go_router/go_router.dart';

final GoRoute teacherRoutes = GoRoute(
  path: "/teacher",
  builder: (context, state) => const HomeTeacher(),
);
