import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String? label;

  const AnimatedButton({super.key, required this.onPressed, this.label});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 56.h,
        width: _isPressed ? 260.w : 280.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff6848fd), Color(0xff36edbc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: const Color(0xff6848fd).withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.label ?? 'Start Quiz',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
