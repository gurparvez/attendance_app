import 'package:flutter/material.dart';

@immutable
class ButtonTextPrimary extends StatelessWidget {
  final String text;
  final bool isLoading;

  final VoidCallback onPressed;

  const ButtonTextPrimary(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    print('Primary color: ${colorScheme.primary}');
    print('Secondary color: ${colorScheme.secondary}');
    print('Tertiary color: ${colorScheme.tertiary}');
    print('Surface color: ${colorScheme.surface}');
    print('Error color: ${colorScheme.error}');

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading
            ? Theme.of(context).colorScheme.primary.withOpacity(0.7)
            : Theme.of(context).colorScheme.primary,
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
                color: Theme.of(context).colorScheme.surface,
              ),
            )
          : Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold),
            ),
    );
  }
}
