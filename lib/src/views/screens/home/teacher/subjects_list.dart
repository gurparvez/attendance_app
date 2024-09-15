import 'package:attendance_app/src/views/screens/home/teacher/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SubjectsList extends StatelessWidget {
  const SubjectsList({super.key, required this.subjects});

  final List<Map<String, String>> subjects;

  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty) {
      return const Center(child: Text("No subjects available."));
    }

    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final String subject =
            subjects[index]["subject"] ?? "Unknown Subject";
        final String course =
            subjects[index]["course"] ?? "Unknown Course";

        return CardCourse(subject: subject, course: course);
      },
    );
  }
}