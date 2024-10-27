import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:mac_address/mac_address.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void bluetoothSpeed(
  String teacherId,
  String subjectId,
  DateTime date,
  int time,
) async {
  debugPrint("sending test data...");
  String macAddress = await GetMac.macAddress;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString("token") ?? "";

  Map body = {
    "teacherId": teacherId,
    "subjectId": subjectId,
    "macAddress": macAddress,
    "date": DateFormat('yyyy-MM-dd').format(date),
    "time": time,
  };

  final String url = dotenv.env["SERVER_URL"] ?? "";

  debugPrint(jsonEncode(body));

  try {
    http.Response response = await http.post(
      Uri.parse("$url/test/test-data"),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      debugPrint("test data sent");
    } else {
      debugPrint(response.body);
    }
  } catch(e) {
    debugPrint(e.toString());
  }
}
