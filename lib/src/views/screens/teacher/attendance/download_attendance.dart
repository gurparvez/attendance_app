import 'package:attendance_app/src/models/subject_teacher.model.dart';
import 'package:attendance_app/src/views/widgets/buttons/button_text_primary.dart';
import 'package:attendance_app/src/views/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DownloadAttendance extends StatefulWidget {
  const DownloadAttendance({
    super.key,
    required this.subjectId,
    required this.subject,
  });

  final String subjectId;
  final SubjectTeacherModel subject;

  @override
  State<DownloadAttendance> createState() => _DownloadAttendanceState();
}

class _DownloadAttendanceState extends State<DownloadAttendance> {
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime.now();

  void _selectStartDate(DateTime date) {
    setState(() {
      startDate = date;
    });
  }

  void _selectEndDate(DateTime date) {
    setState(() {
      endDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go("/teacher/profile");
            },
            icon: const Icon(Icons.account_circle_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Download Attendance",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Subject: ${widget.subject.name}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DatePicker(
                        selectedDate: startDate,
                        onDateSelected: _selectStartDate,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "To",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: DatePicker(
                        selectedDate: endDate,
                        onDateSelected: _selectEndDate,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ButtonTextPrimary(
                  text: "Download CSV",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
