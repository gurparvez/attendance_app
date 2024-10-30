import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/subject_teacher.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubjectsList extends StatefulWidget {
  @override
  State<SubjectsList> createState() => _SubjectsListState();
}

class _SubjectsListState extends State<SubjectsList> {
  bool _isLoading = true;
  String _responseError = "";
  List<SubjectTeacherModel> subjects = [];

  Future<void> getSubjects() async {
    try {
      setState(() {
        _isLoading = true;
        _responseError = "";
      });
      ApiResponse<List<SubjectTeacherModel>> subjectsData =
      await Api().teacher.getSubjects();

      if (subjectsData.success) {
        setState(() {
          subjects = subjectsData.data;
        });
      }
    } catch (e) {
      setState(() {
        _responseError = e.toString().replaceAll("Exception: ", "");
        debugPrint(e.toString());
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CardShimmerList();
    }

    if (_responseError.isNotEmpty) {
      return Text(_responseError);
    }

    if (subjects.isEmpty) {
      return const Center(child: Text("No subjects available."));
    }

    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return CardSubject(
          title: subjects[index].course![0].name!.toUpperCase(),
          subtitle: "Subject: ${subjects[index].name!}",
          onPressed: () {
            context.go("/teacher/attendance/${subjects[index].sId}", extra: subjects[index]);
          },
        );
      },
    );
  }
}
