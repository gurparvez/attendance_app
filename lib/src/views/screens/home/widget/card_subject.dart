import 'package:flutter/material.dart';

class CardSubject extends StatefulWidget {
  CardSubject({
    super.key,
    this.elevation,
    required this.icon,
    required this.subject,
    required this.course,
  });

  double? elevation;
  final String icon;
  final String subject;
  final String course;

  @override
  State<CardSubject> createState() => _CardSubjectState();
}

class _CardSubjectState extends State<CardSubject> {
  @override
  void initState() {
    super.initState();
    widget.elevation = widget.elevation ?? 4;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4, // Adds a shadow to the card
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/subjectImages/code.jpg",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding inside the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(
                  widget.subject,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.course,
                  style: textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
