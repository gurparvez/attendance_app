import 'package:attendance_app/src/models/subject.student.model.dart';
import 'package:attendance_app/src/views/screens/student/attendance/calender_stat.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AttendanceStudent extends StatefulWidget {
  const AttendanceStudent(
      {super.key, required this.subjectId, required this.subject});

  final String subjectId;
  final SubjectStudentModel subject;

  @override
  State<AttendanceStudent> createState() => _AttendanceStudentState();
}

class _AttendanceStudentState extends State<AttendanceStudent> {
  ValueNotifier<String> _selectedMonth = ValueNotifier<String>("");

  void _handleMonthSelected(String month) {
    setState(() {
      _selectedMonth.value = month;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedMonth.addListener(() {
      // _getAttendanceData();
      print(_selectedMonth.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Attendance",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Subject: ${widget.subject.name}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              // const SizedBox(height: 20),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        MonthPicker(onMonthSelected: _handleMonthSelected),
                      ],
                    ),
                    CalenderStat(
                      subjectId: widget.subjectId,
                      month: _selectedMonth.value,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonTextPrimary(
                          text: "Add Today's",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
