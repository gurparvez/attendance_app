import 'dart:convert';
import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/user.model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class User {
  final String url = dotenv.env["SERVER_URL"] ?? "";

  Future<ApiResponse<UserModel>> login(Map<String, dynamic> data) async {
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
}
