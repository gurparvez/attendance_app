import 'dart:convert';
import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/user.model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

      if (responseData["success"]) {
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

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove("token");
    } catch (e) {
      throw Exception("Something went wrong, unable to logout!");
    }
  }
}
