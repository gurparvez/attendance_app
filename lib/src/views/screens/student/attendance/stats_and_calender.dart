import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/subject_attendance.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class StatsAndCalender extends StatefulWidget {
  const StatsAndCalender({
    super.key,
    required this.subjectId,
    required this.startDate,
    required this.endDate,
  });

  final String subjectId;
  final DateTime startDate;
  final DateTime endDate;

  @override
  State<StatsAndCalender> createState() => _StatsAndCalenderState();
}

class _StatsAndCalenderState extends State<StatsAndCalender> {
  bool _isLoading = true;
  String _responseError = "";
  List<SubjectAttendanceModel> attendanceList = [];
  int totalClasses = 0;
  int presentClasses = 0;
  int absentClasses = 0;
  double percentage = 0.0;

  @override
  void initState() {
    _getAttendanceData();
    super.initState();
  }

  @override
  void didUpdateWidget(StatsAndCalender oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.startDate != oldWidget.startDate ||
        widget.endDate != oldWidget.endDate) {
      _getAttendanceData(); // Fetch new data
    }
  }

  void _getAttendanceData() async {
    try {
      setState(() {
        _isLoading = true;
        _responseError = "";
      });
      debugPrint("getting attendance...");
      ApiResponse<List<SubjectAttendanceModel>> attendanceResponse =
          await Api().student.getSubjectAttendance(
                widget.subjectId,
                widget.startDate,
                widget.endDate,
              );
      if (attendanceResponse.success) {
        setState(() {
          attendanceList = attendanceResponse.data;
          totalClasses =
              attendanceList.where((day) => day.facultyPresent == true).length;
          presentClasses = attendanceList
              .where((day) => day.facultyPresent == true && day.present == true)
              .length;
          absentClasses = totalClasses - presentClasses;
          percentage =
              totalClasses <= 0 ? 0 : (presentClasses / totalClasses) * 100;
        });
      }
    } catch (e) {
      setState(() {
        _responseError = "Could not get attendance: $e";
        debugPrint(e.toString());
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? StatsAndCalenderLoader()
        : _responseError != ""
            ? Center(child: Text(_responseError))
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: cardStat("Classes", "$totalClasses")),
                      Expanded(child: cardStat("Present", "$presentClasses")),
                      Expanded(child: cardStat("Absent", "$absentClasses")),
                      Expanded(
                        child: cardStat(
                          "Attendance",
                          "${percentage.toStringAsFixed(2)} %",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SfCalendar(
                    view: CalendarView.month,
                    minDate: widget.startDate,
                    maxDate: widget.endDate,
                    dataSource: AttendanceDataSource(attendanceList),
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.indicator,
                    ),
                    showNavigationArrow: true,
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
  AttendanceDataSource(List<SubjectAttendanceModel> attendances) {
    appointments = attendances;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].date);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments![index].date)
        .add(const Duration(hours: 1)); // 1-hour event
  }

  @override
  String getSubject(int index) {
    return appointments![index].present && appointments![index].facultyPresent
        ? 'Present'
        : 'Absent';
  }

  @override
  Color getColor(int index) {
    return appointments![index].present && appointments![index].facultyPresent
        ? Colors.green
        : Colors.red;
  }

  @override
  bool isAllDay(int index) {
    return true; // Mark it as an all-day event
  }
}
