import 'package:flutter/material.dart';

class BluetoothEffect extends StatefulWidget {
  const BluetoothEffect({super.key});

  @override
  State<BluetoothEffect> createState() => _BluetoothEffectState();
}

class _BluetoothEffectState extends State<BluetoothEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
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
            child: const Icon(
              Icons.bluetooth,
              size: 40,
              color: Colors.black,
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
