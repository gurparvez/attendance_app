import 'package:attendance_app/src/views/screens/home/student/widgets/card_subject.dart';
import 'package:flutter/material.dart';

class SubjectsList extends StatefulWidget {
  const SubjectsList({super.key, required this.subjects});

  final List<Map<String, String>> subjects;

  @override
  State<SubjectsList> createState() => _SubjectsListState();
}

class _SubjectsListState extends State<SubjectsList> {
  @override
  Widget build(BuildContext context) {
    if (widget.subjects.isEmpty) {
      return const Center(child: Text("No subjects available."));
    }

    return ListView.builder(
      itemCount: widget.subjects.length,
      itemBuilder: (context, index) {
        final String subject =
            widget.subjects[index]["subject"] ?? "Unknown Subject";
        final String course =
            widget.subjects[index]["course"] ?? "Unknown Course";

        return CardSubject(subject: subject, course: course);
      },
    );
  }
}
