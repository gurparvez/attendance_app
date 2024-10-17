import 'dart:async';

import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/mark_faculty_attendance.model.dart';
import 'package:attendance_app/src/models/subject_teacher.model.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';

class Bluetooth extends StatefulWidget {
  const Bluetooth({super.key, required this.subject});

  final SubjectTeacherModel subject;

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  bool _isLoading = false;
  String _responseError = "";
  final Strategy strategy = Strategy.P2P_STAR;
  int _timeRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _markAttendance();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeRemaining > 0) {
            debugPrint("Time remaining: $_timeRemaining");
            _timeRemaining--;
          } else {
            timer.cancel();
            Navigator.pop(context);
          }
        });
      }
    });
  }

  void _markAttendance() async {
    setState(() {
      _isLoading = true;
      _responseError = "";
    });
    try {
      debugPrint("marking attendance...");
      ApiResponse<MarkFacultyAttendanceModel> response =
          await Api().teacher.markFacultyAttendance(
                DateTime.now(),
                widget.subject.facultyId!,
                widget.subject.sId!,
              );
      if (response.success) {
        debugPrint("Attendance marked");
        _requestPermissionsAndStartAdvertisement();
      }
    } catch (e) {
      setState(() {
        _responseError = "$e";
        debugPrint(e.toString());
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(
          "/student/bluetooth/error",
          extra: _responseError,
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _requestPermissionsAndStartAdvertisement() async {
    final goRouter = GoRouter.of(context);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.location,
      Permission.nearbyWifiDevices,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (allGranted) {
      _startAdvertising();
      _startTimer();
    } else {
      debugPrint('Permissions not granted. Discovery cannot start.');
      goRouter.go(
        "/student/bluetooth/error",
        extra: "Required permissions not granted!",
      );
    }
  }

  Future<void> _startAdvertising() async {
    try {
      bool advertising = await Nearby().startAdvertising(
        '${widget.subject.sId}:${widget.subject.facultyId}',
        strategy,
        onConnectionInitiated: (id, info) {
          // No connection required, so we reject it immediately.
          Nearby().rejectConnection(id);
          debugPrint('Connection request rejected from: $id');
        },
        onConnectionResult: (id, status) {
          // Just to ensure no unexpected connections are established.
          debugPrint('Connection result: $status');
        },
        onDisconnected: (id) {
          debugPrint('Disconnected from: $id');
        },
      );
      debugPrint('Advertising started: $advertising');
    } catch (e) {
      debugPrint('Error starting advertising: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const FullScreenSpinner(message: "Marking your attendance");
    }
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          const BluetoothEffect(),
          const SizedBox(height: 30),
          Text(
            "Taking Attendance $_timeRemaining",
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
              onPressed: () async {
                await Nearby().stopAdvertising();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
