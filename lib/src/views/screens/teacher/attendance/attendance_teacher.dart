import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/change_attendance.model.dart';
import 'package:attendance_app/src/models/students_attendance.model.dart';
import 'package:attendance_app/src/models/subject_teacher.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/utils/format_name.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  String _responseErrorAttendance = "";
  DateTime date = DateTime.now();
  StudentsAttendanceModel studentsList = StudentsAttendanceModel();
  Map<String, bool> studentAttendanceLoading = <String, bool>{};
  String _searchQuery = "";

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
        final students = studentsListResponse.data[0].students!;
        setState(() {
          for (var student in students) {
            // If the student is not already in the map, set their initial attendance to false
            studentAttendanceLoading.putIfAbsent(
              student.user!.sId!,
              () => false,
            );
          }
        });
        setState(() {
          studentsList = studentsListResponse.data[0];
        });
      }
    } catch (e) {
      setState(() {
        _responseError = e.toString().replaceAll("Exception: ", "");
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
      // Create a new map instance to trigger the state update properly
      studentAttendanceLoading = {
        ...studentAttendanceLoading,
        studentId: true,
      };
      debugPrint(
          "Updated loading state: $studentId -> ${studentAttendanceLoading[studentId]}");
    });

    try {
      debugPrint("marking attendance...");
      ApiResponse<ChangeAttendanceModel> response =
          await Api().teacher.markAttendance(subjectId, date, studentId);
      if (response.success) {
        await _getUpdatedStudentAttendance(studentId, date);
      }
    } catch (e) {
      setState(() {
        _responseErrorAttendance = e.toString().replaceAll("Exception: ", "");
      });
    } finally {
      setState(() {
        studentAttendanceLoading = {
          ...studentAttendanceLoading,
          studentId: false,
        };
      });
    }
  }

  void _unMarkAttendance(
    DateTime date,
    String subjectId,
    String studentId,
  ) async {
    setState(() {
      studentAttendanceLoading = {
        ...studentAttendanceLoading,
        studentId: true,
      };
      debugPrint(
          "Updated loading state: $studentId -> ${studentAttendanceLoading[studentId]}");
    });

    try {
      debugPrint("unMarking attendance...");
      ApiResponse<ChangeAttendanceModel> response =
          await Api().teacher.unMarkAttendance(subjectId, date, studentId);
      if (response.success) {
        await _getUpdatedStudentAttendance(studentId, date);
      }
    } catch (e) {
      setState(() {
        _responseErrorAttendance = e.toString().replaceAll("Exception: ", "");
      });
    } finally {
      setState(() {
        studentAttendanceLoading = {
          ...studentAttendanceLoading,
          studentId: false,
        };
      });
    }
  }

  Future<void> _getUpdatedStudentAttendance(
      String studentId, DateTime date) async {
    // setState(() {
    //   studentAttendanceLoading[studentId] = true;
    // });
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
        _responseErrorAttendance = e.toString().replaceAll("Exception: ", "");
      });
    }
    // finally {
    //   setState(() {
    //     studentAttendanceLoading[studentId] = false;
    //   });
    // }
  }

  List<Students> _getFilteredStudents() {
    if (_searchQuery.isEmpty) {
      return studentsList.students ?? [];
    }

    return studentsList.students?.where((student) {
      final name = student.user?.name?.toLowerCase() ?? '';
      final auid = student.user?.auid?.toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();

      return name.contains(query) || auid.contains(query);
    }).toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    if (_responseErrorAttendance.isNotEmpty) {
      Fluttertoast.showToast(
        msg: _responseErrorAttendance,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(
                '/teacher/downloadCSV/${widget.subjectId}',
                extra: widget.subject,
              );
            },
            icon: const Icon(Icons.sim_card_download_outlined),
          ),
          IconButton(
            onPressed: () {
              context.go("/teacher/profile");
            },
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
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DatePicker(selectedDate: date, onDateSelected: _selectDate),
                if ((studentsList.students ?? []).isNotEmpty) ...[
                  Expanded(
                    child: cardStat(
                      "Total",
                      _getFilteredStudents().length.toString(),
                    ),
                  ),
                  Expanded(
                    child: cardStat(
                      "Present",
                      _getFilteredStudents()
                          .where((student) => student.present!)
                          .length
                          .toString(),
                    ),
                  ),
                  Expanded(
                    child: cardStat(
                      "Absent",
                      _getFilteredStudents()
                          .where((student) => !student.present!)
                          .length
                          .toString(),
                    ),
                  ),
                ]
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _responseError.isNotEmpty
                      ? Center(child: Text(_responseError))
                      : ListView.builder(
                          itemCount: _getFilteredStudents().length,
                          itemBuilder: (context, index) {
                            final student = _getFilteredStudents()[index];

                            return ListTile(
                              leading: student.present!
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                              title: Text(formatName(student.user!.name!)),
                              subtitle: Text(student.user!.auid!),
                              trailing: student.present!
                                  ? ButtonTextSecondary(
                                      text: "UnMark",
                                      isLoading: studentAttendanceLoading[
                                          student.user!.sId]!,
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
                                      isLoading: studentAttendanceLoading[
                                          student.user!.sId]!,
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
