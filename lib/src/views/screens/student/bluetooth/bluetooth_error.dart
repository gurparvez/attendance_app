import 'package:attendance_app/src/views/widgets/buttons/button_text_primary.dart';
import 'package:flutter/material.dart';

class BluetoothError extends StatelessWidget {
  const BluetoothError({super.key, required this.getTeacherPresentStatus});

  final void Function() getTeacherPresentStatus;

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
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                  child: const Icon(Icons.close, size: 48),
                ),
                const SizedBox(height: 20),
                Text(
                  "Couldn't find Teacher",
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
            child: ButtonTextPrimary(
              text: "Try Again",
              onPressed: () {
                getTeacherPresentStatus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
