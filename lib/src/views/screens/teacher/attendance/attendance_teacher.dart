import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/change_attendance.model.dart';
import 'package:attendance_app/src/models/students_attendance.model.dart';
import 'package:attendance_app/src/models/subject.teacher.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AttendanceTeacher extends StatefulWidget {
  const AttendanceTeacher({
    super.key,
    required this.subjectId,
    required this.subject,
  });

  final String subjectId;
  final SubjectTeacherModel subject;

  @override
  State<AttendanceTeacher> createState() => _AttendanceTeacherState();
}

class _AttendanceTeacherState extends State<AttendanceTeacher> {
  bool _isLoading = false;
  String _responseError = "";
  bool _isLoadingAttendance = false;
  String _responseErrorAttendance = "";
  DateTime date = DateTime.now();
  StudentsAttendanceModel studentsList = StudentsAttendanceModel();

  @override
  void initState() {
    _getAttendance();
    super.initState();
  }

  void _selectDate(DateTime newDate) {
    setState(() {
      date = newDate;
    });
    _getAttendance();
  }

  void _getAttendance({bool showFullLoader = true}) async {
    if (showFullLoader) {
      setState(() {
        _isLoading = true;
        _responseError = "";
      });
    }
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

  void _markAttendance(
    DateTime date,
    String subjectId,
    String studentId,
  ) async {
    setState(() {
      _isLoadingAttendance = true;
    });
    try {
      debugPrint("marking attendance...");
      ApiResponse<ChangeAttendanceModel> response =
          await Api().teacher.markAttendance(subjectId, date, studentId);
      if (response.success) {
        _getUpdatedStudentAttendance(studentId, date);
      }
    } catch (e) {
      setState(() {
        _responseErrorAttendance = "$e";
        debugPrint(e.toString());
      });
    } finally {
      setState(() {
        _isLoadingAttendance = false;
      });
    }
  }

  void _unMarkAttendance(
    DateTime date,
    String subjectId,
    String studentId,
  ) async {
    setState(() {
      _isLoadingAttendance = true;
    });
    try {
      debugPrint("marking attendance...");
      ApiResponse<ChangeAttendanceModel> response =
          await Api().teacher.unmarkAttendance(subjectId, date, studentId);
      if (response.success) {
        _getUpdatedStudentAttendance(studentId, date);
      }
    } catch (e) {
      setState(() {
        _responseErrorAttendance = "$e";
        debugPrint(e.toString());
      });
    } finally {
      setState(() {
        _isLoadingAttendance = false;
      });
    }
  }

  void _getUpdatedStudentAttendance(String studentId, DateTime date) async {
    setState(() {
      _isLoadingAttendance = true;
    });
    try {
      ApiResponse<List<StudentsAttendanceModel>> response =
          await Api().teacher.getSubjectAttendance(widget.subjectId, date);

      if (response.success && response.data.isNotEmpty) {
        StudentsAttendanceModel updatedData = response.data[0];

        // Update the student's attendance
        final updatedStudent = updatedData.students!.firstWhere(
          (student) => student.user?.sId == studentId,
        );
        final index = studentsList.students!.indexWhere(
              (student) => student.user?.sId == studentId,
        );
        if (index != -1) {
          setState(() {
            studentsList.students![index].present = updatedStudent.present;
          });
        }
      }
    } catch (e) {
      setState(() {
        _responseErrorAttendance = "$e";
      });
    } finally {
      setState(() {
        _isLoadingAttendance = false;
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
                                  : const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                              title: Text(student.user!.name!),
                              subtitle: Text(student.user!.auid!),
                              trailing: student.present!
                                  ? ButtonTextSecondary(
                                      text: "UnMark",
                                      isLoading: _isLoadingAttendance,
                                      onPressed: () {
                                        _unMarkAttendance(
                                          date,
                                          widget.subjectId,
                                          student.user!.sId!,
                                        );
                                      },
                                    )
                                  : ButtonTextPrimary(
                                      text: "Mark",
                                      isLoading: _isLoadingAttendance,
                                      onPressed: () {
                                        _markAttendance(
                                          date,
                                          widget.subjectId,
                                          student.user!.sId!,
                                        );
                                      },
                                    ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go("/teacher/bluetooth", extra: widget.subject);
        },
        child: const Icon(Icons.bluetooth_audio),
      ),
    );
  }
}
