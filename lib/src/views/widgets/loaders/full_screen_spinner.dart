import 'package:attendance_app/src/views/widgets/buttons/button_text_secondary.dart';
import 'package:flutter/material.dart';

class FullScreenSpinner extends StatelessWidget {
  const FullScreenSpinner({
    super.key,
    required this.message,
    this.onCancel = _removeCurrentPage,
  });

  final String message;
  final void Function(BuildContext context) onCancel;

  static void _removeCurrentPage(BuildContext context) {
    Navigator.pop(context);
  }

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
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  message,
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
              onPressed: () => onCancel(context),
            ),
          ),
        ],
      ),
    );
  }
}
