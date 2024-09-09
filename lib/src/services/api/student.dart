import 'dart:convert';
import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/student.model.dart';
import 'package:http/http.dart' as http;

class Student {
  final String url = "https://attendance-d3x2.onrender.com/api/v1";

  Future<ApiResponse<StudentModel>> getStudent(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$url/user"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
          "Content-Type": "application/json; charset=UTF-8",
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
}