import 'dart:convert';
import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/department.model.dart';
import 'package:attendance_app/src/models/user.model.dart';
import 'package:attendance_app/src/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<ApiResponse<DepartmentModel>> getDepartmentFromId(
    String departmentId,
  ) async {
    Map<String, String> body = <String, String>{
      "id": departmentId,
    };

    try {
      debugPrint("getting department...");
      final response = await http.post(
        Uri.parse("$url/department"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return ApiResponse<DepartmentModel>.fromJson(
          responseData,
          (data) => DepartmentModel.fromJson(data),
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

  Future<bool> resetPassword(String oldPass, String newPass) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    Map<String, String> body = <String, String>{
      "oldPassword": oldPass,
      "newPassword": newPass,
    };

    try {
      debugPrint("resetting password...");
      final response = await http.post(
        Uri.parse("$url/user/update-password"),
        headers: <String, String>{
          "Authorization": "Bearer $token",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body.toString());

      if (responseData["success"]) {
        return true;
      } else {
        throw Exception(
          "${responseData["message"]}",
        );
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  void logout(WidgetRef ref) async {
    const storage = FlutterSecureStorage();

    try {
      await storage.delete(key: "token");
      ref.read(userProvider.notifier).clearUser();
      debugPrint("Logout success");
    } catch (e) {
      throw Exception("Something went wrong!");
    }
  }
}
