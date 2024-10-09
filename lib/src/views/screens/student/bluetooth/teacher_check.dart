import 'package:attendance_app/src/views/widgets/buttons/button_text_secondary.dart';
import 'package:flutter/material.dart';

class TeacherCheck extends StatelessWidget {
  const TeacherCheck({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isLoading
                    ? CircularProgressIndicator()
                    : const Text("Teacher is present"),
                SizedBox(height: 20),
                Text(
                  'Checking if Teacher is Present',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: ButtonTextSecondary(
              text: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
