import 'package:flutter/material.dart';
import 'dart:math';

import 'package:nd_connect_techland/components/styles.dart';

class CustomThreeInOutLoader extends StatefulWidget {
  @override
  _CustomThreeInOutLoaderState createState() => _CustomThreeInOutLoaderState();
}

class _CustomThreeInOutLoaderState extends State<CustomThreeInOutLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
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
      child: SizedBox(
        width: 100,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDot(0),
                _buildDot(1),
                _buildDot(2),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    final double animationValue = sin(_controller.value * 2 * pi - (pi / 3) * index);
    final double scale = 0.5 + (animationValue * 0.5);
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: appColor2,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
