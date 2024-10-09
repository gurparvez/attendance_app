import 'package:attendance_app/src/views/widgets/buttons/button_text_secondary.dart';
import 'package:flutter/material.dart';

class FindTeacher extends StatefulWidget {
  const FindTeacher({super.key});

  @override
  State<FindTeacher> createState() => _FindTeacherState();
}

class _FindTeacherState extends State<FindTeacher>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Repeat without reversing to ensure ripple effect only expands
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Ripple circles expanding outwards
                _buildRipple(0.0),
                _buildRipple(0.5),
                _buildRipple(1.0),
                // Bluetooth Icon in the center
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.bluetooth,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Finding Teacher',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: ButtonTextSecondary(
              text: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRipple(double delay) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double scale = (_controller.value + delay) % 1.0;
        return Transform.scale(
          scale: scale * 2, // Controls the size of the ripple
          child: Opacity(
            opacity: 1.0 - scale,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
