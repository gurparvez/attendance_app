import 'dart:convert';
import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/models.dart';
import 'package:http/http.dart' as http;

class User {
  final String url = "https://attendance-d3x2.onrender.com/api/v1";

  Future<ApiResponse> login(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("$url/user"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return ApiResponse<UserModel>.fromJson(
          responseData,
          (data) => UserModel.fromJson(data),
        );
      } else {
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception('Error occurred during login: $e');
    }
  }

  void logout() {}

  void getUser() {}
}
