import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/student.model.dart';
import 'package:attendance_app/src/models/teacher.model.dart';
import 'package:attendance_app/src/providers/user_provider.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    final role = await storage.read(key: "user_role");

    if (token == null || role == null) {
      if (!mounted) return;
      context.go('/login');
      return;
    }

    try {
      if (role == "faculty") {
        final ApiResponse<TeacherModel> response =
            await Api().teacher.getTeacher();
        if (response.success) {
          ref.read(userProvider.notifier).setUser(response.data);
          if (!mounted) return;
          context.go('/teacher');
        }
      } else if (role == "student") {
        final ApiResponse<StudentModel> response =
            await Api().student.getStudent();
        if (response.success) {
          ref.read(userProvider.notifier).setUser(response.data);
          if (!mounted) return;
          context.go('/student');
        }
      }
    } catch (e) {
      await storage.deleteAll();
      if (!mounted) return;
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
