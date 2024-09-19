import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/subject.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/screens/home/student/widgets/widgets.dart';
import 'package:attendance_app/src/views/widgets/loaders/card_shimmer_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectsList extends StatefulWidget {
  const SubjectsList({super.key});

  @override
  State<SubjectsList> createState() => _SubjectsListState();
}

class _SubjectsListState extends State<SubjectsList> {
  bool _isLoading = true;
  String _responseError = "";
  List<SubjectModel> subjects = [];

  Future<void> getSubjects() async {
    try {
      setState(() {
        _isLoading = true;
        _responseError = "";
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString("token") ?? "";
      ApiResponse<List<SubjectModel>> subjectsData =
          await Api().student.getSubjects(token);

      if (subjectsData.success) {
        setState(() {
          subjects = subjectsData.data;
        });
      }
    } catch (e) {
      setState(() {
        _responseError = "Could not get subjects: $e";
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
                    onPressed: () {},
                  );
                },
              );
  }
}
