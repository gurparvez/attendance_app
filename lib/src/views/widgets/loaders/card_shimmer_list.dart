import 'package:attendance_app/src/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardShimmerList extends StatelessWidget {
  final int? length;

  const CardShimmerList({super.key, this.length});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: length ?? 4,
      itemBuilder: (context, index) {
        return const Column(
          children: [
            CardShimmer(),
            SizedBox(
              height: 12,
            )
          ],
        );
      },
    );
  }
}
