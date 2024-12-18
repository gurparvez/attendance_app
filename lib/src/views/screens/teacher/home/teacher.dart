import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/teacher.model.dart';
import 'package:attendance_app/src/providers/teacher_provider.dart';
import 'package:attendance_app/src/providers/user_provider.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/screens/teacher/home/subjects_list.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeTeacher extends ConsumerStatefulWidget {
  const HomeTeacher({super.key});

  @override
  ConsumerState<HomeTeacher> createState() => _HomeTeacherState();
}

class _HomeTeacherState extends ConsumerState<HomeTeacher> {
  bool isLoading = false;

  Future<void> getTeacher() async {
    try {
      setState(() {
        isLoading = true;
      });
      ApiResponse<TeacherModel> teacherData =
          await Api().teacher.getTeacher();

      if (teacherData.success) {
        if (!mounted) return;
        ref.read(teacherProvider.notifier).setTeacher(teacherData.data);
      }
    } catch (error) {
      debugPrint("ERROR: $error");
      if (!mounted) return;
      context.go("/");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // getTeacher();
  }

  @override
  Widget build(BuildContext context) {
    final teacher = ref.watch(userProvider);

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
                  onPressed: () {
                    context.go("/teacher/profile");
                  },
                  icon: const Icon(Icons.account_circle_outlined),
                ),
              ],
              forceMaterialTransparency: true,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HomeTitle(name: teacher!.user!.name!),
                  const Expanded(
                    child: SubjectsList(),
                  ),
                ],
              ),
            ),
          );
  }
}
