import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/core/routing/routes.dart';
import 'package:quiz_app/features/quiz/logic/quiz_cubit.dart';

class ResultsScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  const ResultsScreen({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Results',
          style: GoogleFonts.poppins(
            color: const Color(0xff36edbc),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xff1f1147),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff1f1147),
              Color(0xff311b6d),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Score',
                style: GoogleFonts.poppins(
                  fontSize: 32.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              CircleAvatar(
                radius: 70.r,
                backgroundColor: const Color(0xff36edbc),
                child: Text(
                  '$correctAnswers/$totalQuestions',
                  style: GoogleFonts.poppins(
                    fontSize: 34.sp,
                    color: const Color(0xff1f1147),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6848fd),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                onPressed: () {
                  context.read<QuizCubit>().resetQuiz();
                  context.pushReplacement(Routes.quizScreen);
                },
                child: Text(
                  'Restart Quiz',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
