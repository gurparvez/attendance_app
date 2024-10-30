import 'package:flutter/material.dart';

@immutable
class ButtonTextPrimaryRed extends StatelessWidget {
  final String text;
  final bool isLoading;

  final VoidCallback onPressed;

  const ButtonTextPrimaryRed({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading
            ? const Color.fromRGBO(255, 186, 186, 0.7)
            : colorScheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: Color.fromRGBO(202, 18, 18, 1.0), // Set the border color
            width: 2.0, // Set the border width
          ),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: colorScheme.surface,
              ),
            )
          : Text(
              text,
              style: const TextStyle(
                  color: Color.fromRGBO(202, 18, 18, 1.0),
                  fontWeight: FontWeight.bold),
            ),
    );
  }
}
