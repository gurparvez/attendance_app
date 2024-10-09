import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/is_teacher_present.model.dart';
import 'package:attendance_app/src/models/subject.student.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/screens/student/bluetooth/bluetooth_error.dart';
import 'package:attendance_app/src/views/screens/student/bluetooth/find_teacher.dart';
import 'package:attendance_app/src/views/screens/student/bluetooth/teacher_check.dart';
import 'package:attendance_app/src/views/widgets/buttons/button_text_secondary.dart';
import 'package:flutter/material.dart';

class Bluetooth extends StatefulWidget {
  const Bluetooth({super.key, required this.subject});

  final SubjectStudentModel subject;

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  bool isTeacherPresent = false;
  bool _isLoadingTeacherPresent = true;
  String _responseErrorTeacherPresent = "";

  @override
  void initState() {
    getTeacherPresentStatus();
    super.initState();
  }

  void getTeacherPresentStatus() async {
    DateTime date = DateTime.now();
    String facultyId = widget.subject.faculty!.sId!;
    String subjectId = widget.subject.id!;

    try {
      setState(() {
        _isLoadingTeacherPresent = true;
        _responseErrorTeacherPresent = "";
      });

      debugPrint(facultyId);
      debugPrint(subjectId);

      ApiResponse<IsTeacherPresentModel> response =
          await Api().student.isTeacherPresent(date, facultyId, subjectId);
      if (response.success) {
        isTeacherPresent = true;
      }
    } catch (e) {
      setState(() {
        _responseErrorTeacherPresent = "Could not get teacher's presence: $e";
        debugPrint(_responseErrorTeacherPresent);
      });
    } finally {
      _isLoadingTeacherPresent = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (_isLoadingTeacherPresent) {
    //   return TeacherCheck(isLoading: _isLoadingTeacherPresent);
    // }
    // if (_responseErrorTeacherPresent.isNotEmpty) {
    //   return BluetoothError(getTeacherPresentStatus: getTeacherPresentStatus);
    // }
    return FindTeacher();
    // else {
    //   return Scaffold(
    //     body: Center(child: Text("Teacher is present")),
    //   );
    // }
  }
}
