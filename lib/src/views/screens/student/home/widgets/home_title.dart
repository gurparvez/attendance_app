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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Hello,",
          style: textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formatName(),
          style: textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w900,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
