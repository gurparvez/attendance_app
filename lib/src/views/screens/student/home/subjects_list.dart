import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/subject.student.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubjectsList extends StatefulWidget {
  const SubjectsList({super.key});

  @override
  State<SubjectsList> createState() => _SubjectsListState();
}

class _SubjectsListState extends State<SubjectsList> {
  bool _isLoading = true;
  String _responseError = "";
  List<SubjectStudentModel> subjects = [];

  Future<void> getSubjects() async {
    try {
      setState(() {
        _isLoading = true;
        _responseError = "";
      });
      ApiResponse<List<SubjectStudentModel>> subjectsData =
          await Api().student.getSubjects();

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
    return _isLoading
        ? const CardShimmerList()
        : _responseError != ""
            ? Text(_responseError)
            : ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return CardSubject(
                    title: subjects[index].name!,
                    subtitle: "Professor: ${subjects[index].faculty!.name!}",
                    onPressed: () {
                      context.go("/student/attendance/${subjects[index].id}", extra: subjects[index]);
                    },
                  );
                },
              );
  }
}
