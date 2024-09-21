import 'dart:convert';

import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/teacher.model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Teacher {
  final String url = dotenv.env["SERVER_URL"] ?? "";

  Future<ApiResponse<TeacherModel>> getTeacher(String token) async {
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
}