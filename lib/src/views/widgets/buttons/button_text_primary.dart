import 'package:flutter/material.dart';

@immutable
class ButtonTextPrimary extends StatelessWidget {
  final String text;
  final bool isLoading;

  final VoidCallback onPressed;

  const ButtonTextPrimary({
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
            ? colorScheme.primary.withOpacity(0.7)
            : colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
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
              style: TextStyle(
                  color: colorScheme.surface, fontWeight: FontWeight.bold),
            ),
    );
  }
}
