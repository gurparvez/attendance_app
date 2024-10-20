import 'dart:convert';
import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/is_teacher_present.model.dart';
import 'package:attendance_app/src/models/mark_student_attendance.model.dart';
import 'package:attendance_app/src/models/student.model.dart';
import 'package:attendance_app/src/models/subject.student.model.dart';
import 'package:attendance_app/src/models/subject_attendance.model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student {
  final String url = dotenv.env["SERVER_URL"] ?? "";

  Future<ApiResponse<StudentModel>> getStudent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token") ?? "";
    try {
      final response = await http.get(
        Uri.parse("$url/student"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<StudentModel>.fromJson(
          responseData,
          (data) => StudentModel.fromJson(data),
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

  Future<ApiResponse<List<SubjectStudentModel>>> getSubjects() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token") ?? "";
    try {
      final response = await http.post(
        Uri.parse("$url/subject/student"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<List<SubjectStudentModel>>.fromJson(
          responseData,
          (data) => (data as List)
              .map((item) => SubjectStudentModel.fromJson(item))
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

  Future<ApiResponse<List<SubjectAttendanceModel>>> getSubjectAttendance(
      String subjectId, DateTime startDate, DateTime endDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token") ?? "";

    Map<String, dynamic> body = {
      "subjectId": subjectId,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
    };

    try {
      final response = await http.post(
        Uri.parse("$url/attendance/student"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<List<SubjectAttendanceModel>>.fromJson(
          responseData,
          (data) => (data as List)
              .map((item) => SubjectAttendanceModel.fromJson(item))
              .toList(),
        );
      } else {
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception('Error occurred while getting attendance: $e');
    }
  }

  Future<ApiResponse<IsTeacherPresentModel>> isTeacherPresent(
    DateTime date,
    String facultyId,
    String subjectId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token") ?? "";

    Map<String, dynamic> body = {
      "date": DateFormat('yyyy-MM-dd').format(date),
      "facultyId": facultyId,
      "subjectId": subjectId,
    };

    try {
      final response = await http.post(
        Uri.parse("$url/attendance/faculty/check"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<IsTeacherPresentModel>.fromJson(
          responseData,
          (data) => IsTeacherPresentModel.fromJson(data),
        );
      } else {
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception('Error occurred getting teacher: $e');
    }
  }

  Future<ApiResponse<MarkStudentAttendanceModel>> markTodaysAttendance(
    String subjectId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString("token") ?? "";

    Map<String, dynamic> body = {
      "subjectId": subjectId,
    };

    try {
      final response = await http.post(
        Uri.parse("$url/attendance/today"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<MarkStudentAttendanceModel>.fromJson(
          responseData,
          (data) => MarkStudentAttendanceModel.fromJson(data),
        );
      } else {
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception("Error occurred marking today's attendance: $e");
    }
  }
}
