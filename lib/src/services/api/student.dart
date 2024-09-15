import 'dart:convert';
import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/student.model.dart';
import 'package:attendance_app/src/models/subject.model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Student {
  final String url = dotenv.env["SERVER_URL"] ?? "";

  Future<ApiResponse<StudentModel>> getStudent(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$url/student"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
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

  Future<ApiResponse<List<SubjectModel>>> getSubjects(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$url/subject/student"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return ApiResponse<List<SubjectModel>>.fromJson(
          responseData,
          (data) => (data as List)
              .map((item) => SubjectModel.fromJson(item))
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
}
