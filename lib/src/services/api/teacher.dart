import 'dart:convert';

import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/students_attendance.model.dart';
import 'package:attendance_app/src/models/subject.teacher.model.dart';
import 'package:attendance_app/src/models/teacher.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Teacher {
  final String url = dotenv.env["SERVER_URL"] ?? "";

  Future<ApiResponse<TeacherModel>> getTeacher() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token") ?? "";
    try {
      final response = await http.get(
        Uri.parse("$url/faculty"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
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
      throw Exception('Error occurred in getting user: $e');
    }
  }

  Future<ApiResponse<List<SubjectTeacherModel>>> getSubjects() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token") ?? "";
    try {
      final response = await http.post(
        Uri.parse("$url/subject/faculty"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
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
      throw Exception('Error occurred while getting subjects: $e');
    }
  }

  Future<ApiResponse<List<StudentsAttendanceModel>>> getSubjectAttendance(
    String subjectId,
    DateTime date,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token") ?? "";

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

      if (response.statusCode == 200) {
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
      throw Exception('Error occurred while getting students: $e');
    }
  }

  unmarkAttendance(String subjectId, DateTime date, String studentId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token") ?? "";

    Map<String, dynamic> body = {
      "studentId": studentId,
      "subjectId": subjectId,
      "date": DateFormat('yyyy-MM-dd').format(date),
    };

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

      if (response.statusCode == 200) {
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
      throw Exception('Error occurred while getting students: $e');
    }
  }
}
