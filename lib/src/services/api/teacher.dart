import 'dart:convert';

import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/change_attendance.model.dart';
import 'package:attendance_app/src/models/mark_faculty_attendance.model.dart';
import 'package:attendance_app/src/models/students_attendance.model.dart';
import 'package:attendance_app/src/models/subject_teacher.model.dart';
import 'package:attendance_app/src/models/teacher.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Teacher {
  final String url = dotenv.env["SERVER_URL"] ?? "";

  Future<ApiResponse<TeacherModel>> getTeacher() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await http.get(
        Uri.parse("$url/faculty"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<TeacherModel>.fromJson(
          responseData,
          (data) => TeacherModel.fromJson(data),
        );
      } else {
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<ApiResponse<List<SubjectTeacherModel>>> getSubjects() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    try {
      final response = await http.post(
        Uri.parse("$url/subject/faculty"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<List<SubjectTeacherModel>>.fromJson(
          responseData,
          (data) => (data as List)
              .map((item) => SubjectTeacherModel.fromJson(item))
              .toList(),
        );
      } else {
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<ApiResponse<List<StudentsAttendanceModel>>> getSubjectAttendance(
    String subjectId,
    DateTime date,
  ) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    Map<String, dynamic> body = {
      "subjectId": subjectId,
      "date": DateFormat('yyyy-MM-dd').format(date),
    };

    debugPrint("Request body: ${jsonEncode(body)}");

    try {
      final response = await http.post(
        Uri.parse("$url/attendance/subject"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<List<StudentsAttendanceModel>>.fromJson(
          responseData,
          (data) => (data as List)
              .map((item) => StudentsAttendanceModel.fromJson(item))
              .toList(),
        );
      } else {
        debugPrint("$responseData");
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<ApiResponse<ChangeAttendanceModel>> markAttendance(
    String subjectId,
    DateTime date,
    String studentId,
  ) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    Map<String, dynamic> body = {
      "studentId": studentId,
      "subjectId": subjectId,
      "date": DateFormat('yyyy-MM-dd').format(date),
    };

    try {
      final response = await http.post(
        Uri.parse("$url/attendance"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<ChangeAttendanceModel>.fromJson(
          responseData,
          (data) => ChangeAttendanceModel.fromJson(data),
        );
      } else {
        debugPrint("$responseData");
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<ApiResponse<ChangeAttendanceModel>> unmarkAttendance(
    String subjectId,
    DateTime date,
    String studentId,
  ) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    Map<String, dynamic> body = {
      "studentId": studentId,
      "subjectId": subjectId,
      "date": DateFormat('yyyy-MM-dd').format(date),
    };

    try {
      final response = await http.delete(
        Uri.parse("$url/attendance/unmark"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<ChangeAttendanceModel>.fromJson(
          responseData,
          (data) => ChangeAttendanceModel.fromJson(data),
        );
      } else {
        debugPrint("$responseData");
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<ApiResponse<MarkFacultyAttendanceModel>> markFacultyAttendance(
    DateTime date,
    String facultyId,
    String subject,
  ) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    Map<String, dynamic> body = {
      "date": DateFormat('yyyy-MM-dd').format(date),
      "facultyId": facultyId,
      "subjectId": subject,
    };

    try {
      final response = await http.post(
        Uri.parse("$url/attendance/faculty"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<MarkFacultyAttendanceModel>.fromJson(
          responseData,
          (data) => MarkFacultyAttendanceModel.fromJson(data),
        );
      } else {
        debugPrint("$responseData");
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }
}
