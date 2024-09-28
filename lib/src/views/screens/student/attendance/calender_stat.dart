import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Attendance> getMockAttendanceData() {
  return [
    Attendance(DateTime(2024, 9, 2), false),
    Attendance(DateTime(2024, 9, 3), true),
    Attendance(DateTime(2024, 9, 4), true),
    Attendance(DateTime(2024, 9, 5), false),
    Attendance(DateTime(2024, 9, 6), true),
    Attendance(DateTime(2024, 9, 9), true),
    Attendance(DateTime(2024, 9, 10), true),
    Attendance(DateTime(2024, 9, 11), true),
    Attendance(DateTime(2024, 9, 12), true),
    Attendance(DateTime(2024, 9, 13), true),
  ];
}

class CalenderStat extends StatefulWidget {
  const CalenderStat({super.key, required this.subjectId, required this.month});

  final String subjectId;
  final String month;

  @override
  State<CalenderStat> createState() => _CalenderStatState();
}

class _CalenderStatState extends State<CalenderStat> {
  @override
  void initState() {
    super.initState();
    _getAttendanceData();
  }

  // TODO: make an api call to get attendance data for the selected month
  void _getAttendanceData() async {
    // await AttendanceService.getAttendanceData(widget.subjectId, widget.month);
  }

  void calculateStates() {
    int totalClasses = getMockAttendanceData().length;
    int presentClasses =
        getMockAttendanceData().where((element) => element.isPresent).length;
    int absentClasses = totalClasses - presentClasses;
    double attendancePercentage = (presentClasses / totalClasses) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            cardStat("Classes", "10"),
            cardStat("Present", "8"),
            cardStat("Absent", "2"),
            cardStat("Attendance", "80%"),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          // height: 400, // Set a fixed height for the calendar
          child: SfCalendar(
            view: CalendarView.month,
            headerHeight: 0,
            dataSource: AttendanceDataSource(getMockAttendanceData()),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            ),
          ),
        ),
      ],
    );
  }
}

class Attendance {
  final DateTime date;
  final bool isPresent;

  Attendance(this.date, this.isPresent);
}

class AttendanceDataSource extends CalendarDataSource {
  AttendanceDataSource(List<Attendance> attendances) {
    appointments = attendances;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].date;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index]
        .date
        .add(const Duration(hours: 1)); // 1-hour event
  }

  @override
  String getSubject(int index) {
    return appointments![index].isPresent ? 'Present' : 'Absent';
  }

  @override
  Color getColor(int index) {
    return appointments![index].isPresent ? Colors.green : Colors.red;
  }

  @override
  bool isAllDay(int index) {
    return true; // Mark it as an all-day event
  }
}
