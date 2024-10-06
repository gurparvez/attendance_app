import 'package:attendance_app/src/models/subject.student.model.dart';
import 'package:attendance_app/src/views/screens/student/attendance/stats_and_calender.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AttendanceStudent extends StatefulWidget {
  const AttendanceStudent(
      {super.key, required this.subjectId, required this.subject});

  final String subjectId;
  final SubjectStudentModel subject;

  @override
  State<AttendanceStudent> createState() => _AttendanceStudentState();
}

class _AttendanceStudentState extends State<AttendanceStudent> {
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime.now();

  void _selectStartDate(DateTime date) {
    setState(() {
      startDate = date;
    });
    debugPrint("$startDate");
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
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
        forceMaterialTransparency: true,
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
                const SizedBox(height: 20),
                Column(
                  children: [
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
                    StatsAndCalender(
                      subjectId: widget.subjectId,
                      startDate: startDate,
                      endDate: endDate,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.bluetooth_audio),
        onPressed: () {},
      ),
    );
  }
}
