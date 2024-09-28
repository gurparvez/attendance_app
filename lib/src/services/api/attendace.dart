import 'package:flutter_dotenv/flutter_dotenv.dart';

class Attendance {
  final String url = dotenv.env["SERVER_URL"] ?? "";

  Future<void> getAttendanceData(String subjectId, String month) async {
    // TODO: make an api call to get attendance data for the selected month
  }
}
