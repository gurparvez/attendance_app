import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/student.model.dart';
import 'package:attendance_app/src/providers/student_provider.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/screens/home/student/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeStudent extends ConsumerStatefulWidget {
  const HomeStudent({super.key});

  @override
  ConsumerState<HomeStudent> createState() => _HomeStudentState();
}

class _HomeStudentState extends ConsumerState<HomeStudent> {
  bool isLoading = true;

  Future<void> getStudent() async {
    try {
      setState(() {
        isLoading = true;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString("token") ?? "";
      ApiResponse<StudentModel> studentData =
          await Api().student.getStudent(token);

      if (studentData.success) {
        if (!mounted) return;
        ref.read(studentProvider.notifier).setStudent(studentData.data);
      }
    } catch (error) {
      debugPrint("ERROR: $error");
      if (!mounted) return;
      context.go("/login");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStudent();
  }

  @override
  Widget build(BuildContext context) {
    final student = ref.watch(studentProvider);

    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle_outlined),
                ),
              ],
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 16,
              ),
              child: Column(
                children: <Widget>[
                  HomeTitle(name: student!.user!.name!),

                ],
              ),
            ),
          );
  }
}
