import 'package:flutter/material.dart';

class CardSubject extends StatelessWidget {
  const CardSubject({
    super.key,
    this.elevation,
    this.cover,
    this.onPressed,
    required this.subject,
    required this.course,
  });

  final double? elevation;
  final VoidCallback? onPressed;
  final String? cover;
  final String subject;
  final String course;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: elevation ?? 4,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              cover ?? "assets/images/subjectImages/code.jpg",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    subject,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course,
                    style: textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
