import 'package:flutter/material.dart';

class ButtonTextPrimary extends StatelessWidget {
  String text;
  bool isLoading;

  VoidCallback onPressed;

  ButtonTextPrimary(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading
            ? const Color.fromARGB(255, 200, 200, 200)
            : const Color.fromARGB(255, 241, 241, 241),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            )
          : Text(text),
    );
  }
}
