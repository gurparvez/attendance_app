import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StatsAndCalenderLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShimmerCard('Classes', '8'),
                  _buildShimmerCard('Present', '6'),
                  // _buildShimmerCard('Absent', '2'),
                  _buildShimmerCard('Attendance', '80%'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: _buildShimmerCalendar(),
              ),
          ],
        ),
      );
  }

  Widget _buildShimmerCard(String title, String value) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 100,
          color: Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildShimmerCalendar() {
    return Container(
      height: 340,  // Set this to match the expected height of your calendar
      width: double.infinity,  // Full width
      color: Colors.grey[300],  // Shimmer background color
    );
  }
}