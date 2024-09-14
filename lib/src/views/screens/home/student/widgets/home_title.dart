import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key, required this.name});

  final String name;

  String formatName() {
    return name.split(" ").map((word) => word.capitalize()).join(" ");
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Hello,",
          style: textTheme.titleLarge,
        ),
        Text(
          formatName(),
          style: textTheme.headlineMedium,
        ),
      ],
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
