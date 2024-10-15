import 'dart:async';

import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/is_teacher_present.model.dart';
import 'package:attendance_app/src/models/mark_student_attendance.model.dart';
import 'package:attendance_app/src/models/subject.student.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';

class Bluetooth extends StatefulWidget {
  const Bluetooth({super.key, required this.subject});

  final SubjectStudentModel subject;

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  bool _isLoadingTeacherPresent = true;
  String _responseErrorTeacherPresent = "";
  bool _isLoadingMarkingAttendance = false;
  String _responseErrorMarkingAttendance = "";

  final Strategy strategy = Strategy.P2P_STAR;

  int _timeRemaining = 60;
  Timer? _timer;

  String teacherId = "";
  String subjectId = "";

  bool _isAttendanceMarked = false;

  @override
  void initState() {
    teacherId = widget.subject.faculty!.sId!;
    subjectId = widget.subject.id!;
    getTeacherPresentStatus();
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          debugPrint("Time remaining: $_timeRemaining");
          _timeRemaining--;
        } else {
          timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  void getTeacherPresentStatus() async {
    DateTime date = DateTime.now();

    try {
      setState(() {
        _isLoadingTeacherPresent = true;
        _responseErrorTeacherPresent = "";
      });

      debugPrint(teacherId);
      debugPrint(subjectId);

      ApiResponse<IsTeacherPresentModel> response =
          await Api().student.isTeacherPresent(date, teacherId, subjectId);
      if (response.success) {
        debugPrint("Teacher present");
        _requestPermissionsAndStartDiscovery();
      }
    } catch (e) {
      setState(() {
        _responseErrorTeacherPresent = "Could not get teacher's attendance: $e";
        debugPrint(_responseErrorTeacherPresent);
      });
    } finally {
      _isLoadingTeacherPresent = false;
    }
  }

  Future<void> _requestPermissionsAndStartDiscovery() async {
    final goRouter = GoRouter.of(context);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.locationWhenInUse,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (allGranted) {
      _startDiscovery();
      _startTimer();
    } else {
      debugPrint('Permissions not granted. Discovery cannot start.');
      goRouter.go(
        "/student/bluetooth/error",
        extra: "Required permissions not granted!",
      );
    }
  }

  void _startDiscovery() async {
    final goRouter = GoRouter.of(context);
    try {
      bool discovering = await Nearby().startDiscovery(
        'student',
        strategy,
        onEndpointFound: (id, name, serviceId) {
          final ids = name.split(':');
          if (subjectId == ids[0] && teacherId == ids[1]) {
            debugPrint('Matched Ids: ${ids[0]}, ${ids[1]}');
            _markAttendance();
          }
        },
        onEndpointLost: (id) {
          debugPrint('Lost connection to endpoint: $id');
        },
      );
      debugPrint('Discovery started: $discovering');
    } catch (e) {
      debugPrint('Error starting discovery: $e');
      goRouter.go(
        "/student/bluetooth/error",
        extra: "Error in starting the find teacher process",
      );
    }
  }

  void _markAttendance() async {
    setState(() {
      _isLoadingMarkingAttendance = true;
      _responseErrorMarkingAttendance = "";
    });
    try {
      debugPrint("marking today's attendance");
      ApiResponse<MarkStudentAttendanceModel> response =
          await Api().student.markTodaysAttendance(subjectId);
      if (response.success) {
        debugPrint("Attendance marked");
        setState(() {
          _isAttendanceMarked = true;
        });
      }
    } catch (e) {
      setState(() {
        _responseErrorMarkingAttendance = "$e";
        debugPrint(e.toString());
      });
    } finally {
      _isLoadingMarkingAttendance = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingTeacherPresent) {
      return const FullScreenSpinner(message: "Checking if teacher is present");
    }
    if (_responseErrorTeacherPresent.isNotEmpty && !_isLoadingTeacherPresent) {
      context.go(
        "/student/bluetooth/error",
        extra: _responseErrorTeacherPresent,
      );
    }

    if (_isLoadingMarkingAttendance) {
      return const FullScreenSpinner(message: "Marking your attendance");
    }
    if (_responseErrorMarkingAttendance.isNotEmpty &&
        !_isLoadingMarkingAttendance) {
      context.go(
        "/student/bluetooth/error",
        extra: _responseErrorMarkingAttendance,
      );
    }

    if (_isAttendanceMarked) {
      return FullScreenSuccess(
        message: "Your Attendance is marked",
        onOkPressed: () {
          Navigator.pop(context);
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          const BluetoothEffect(),
          const SizedBox(height: 30),
          Text(
            "Looking for teacher $_timeRemaining",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: ButtonTextSecondary(
              text: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
