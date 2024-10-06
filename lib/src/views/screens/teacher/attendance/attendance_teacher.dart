import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/students_attendance.model.dart';
import 'package:attendance_app/src/models/subject.teacher.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AttendanceTeacher extends StatefulWidget {
  const AttendanceTeacher(
      {super.key, required this.subjectId, required this.subject});

  final String subjectId;
  final SubjectTeacherModel subject;

  @override
  State<AttendanceTeacher> createState() => _AttendanceTeacherState();
}

class _AttendanceTeacherState extends State<AttendanceTeacher> {
  bool _isLoading = false;
  String _responseError = "";
  DateTime date = DateTime.parse("2024-10-02");
  StudentsAttendanceModel studentsList = StudentsAttendanceModel();

  @override
  void initState() {
    _getAttendance();
    super.initState();
  }

  void _selectDate(DateTime date) {
    setState(() {
      date = date;
    });
  }

  void _getAttendance() async {
    setState(() {
      _isLoading = true;
      _responseError = "";
    });
    try {
      debugPrint("getting students list of subject: ${widget.subjectId}...");
      ApiResponse<List<StudentsAttendanceModel>> studentsListResponse =
          await Api().teacher.getSubjectAttendance(widget.subjectId, date);
      if (studentsListResponse.success) {
        setState(() {
          studentsList = studentsListResponse.data[0];
        });
      }
    } catch (e) {
      setState(() {
        _responseError = "$e";
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
      body: Container(
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
            const SizedBox(height: 20),
            SearchBar(
              leading: const Icon(Icons.search),
              hintText: "Search (name or auid)",
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            DatePicker(selectedDate: date, onDateSelected: _selectDate),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _responseError != ""
                      ? Center(child: Text(_responseError))
                      : ListView.builder(
                          itemCount: studentsList.students!.length,
                          itemBuilder: (context, index) {
                            final student = studentsList.students![index];
                            return ListTile(
                              leading: studentsList.students![index].present!
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : const Icon(Icons.close, color: Colors.red),
                              title: Text(student.user!.name!),
                              subtitle: Text(student.user!.auid!),
                              trailing: student.present!
                                  ? ButtonTextSecondary(
                                      text: "UnMark",
                                      isLoading: _isLoading,
                                      onPressed: () {},
                                    )
                                  : ButtonTextPrimary(
                                      text: "Mark",
                                      isLoading: _isLoading,
                                      onPressed: () {},
                                    ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.bluetooth_audio),
      ),
    );
  }
}
