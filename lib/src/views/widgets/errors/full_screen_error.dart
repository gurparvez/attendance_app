import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FullScreenError extends StatelessWidget {
  const FullScreenError({
    super.key,
    required this.message,
    required this.onTryAgain,
  });

  final String message;
  final void Function() onTryAgain;

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
                  message,
                  style: const TextStyle(
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
              onPressed: onTryAgain,
            ),
          ),
        ],
      ),
    );
  }
}