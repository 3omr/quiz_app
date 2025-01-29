import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedDivider extends StatefulWidget {
  const AnimatedDivider({super.key});

  @override
  _AnimatedDividerState createState() => _AnimatedDividerState();
}

class _AnimatedDividerState extends State<AnimatedDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: 2.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xff36edbc).withOpacity(_controller.value),
                const Color(0xff6848fd).withOpacity(1 - _controller.value),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
