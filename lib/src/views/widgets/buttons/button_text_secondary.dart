import 'package:flutter/material.dart';

class ButtonTextSecondary extends StatefulWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  const ButtonTextSecondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<ButtonTextSecondary> createState() => _ButtonTextSecondaryState();
}

class _ButtonTextSecondaryState extends State<ButtonTextSecondary> {
  @override
  Widget build(BuildContext context) {
    debugPrint("loading state in button: ${widget.isLoading}");
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isLoading
            ? colorScheme.secondaryContainer.withOpacity(0.7)
            : colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: widget.isLoading
          ? const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2.0),
      )
          : Text(
        widget.text,
        style: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
