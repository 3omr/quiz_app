import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/core/routing/routes.dart';
import 'package:quiz_app/features/quiz/logic/quiz_cubit.dart';
import 'package:quiz_app/features/quiz/logic/quiz_state.dart';
import 'package:quiz_app/features/quiz/screens/widgets/animated_button.dart';
import 'package:quiz_app/features/quiz/screens/widgets/animated_divider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QuizCubit>().loadQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Image
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: 220.h,
                  child: Image.network(
                      'https://static.vecteezy.com/system/resources/thumbnails/047/235/502/small_2x/3d-illustration-exam-png.png'),
                ),
                SizedBox(height: 20.h),

                // Title with shadow
                Text(
                  'DocReader QUIZZES',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff36edbc),
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                // Divider with animation
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const AnimatedDivider(),
                ),

                // Subject title
                Text(
                  'Development of Git',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Questions count with loading state
                BlocConsumer<QuizCubit, QuizState>(
                  listener: (context, state) {
                    if (state is QuizRestart) {
                      context.read<QuizCubit>().loadQuiz();
                    }
                  },
                  builder: (context, state) {
                    if (state is QuizLoading) {
                      return const CircularProgressIndicator(
                        color: Color(0xff36edbc),
                      );
                    } else if (state is QuizLoaded) {
                      return Text(
                        '${state.quizQuestions.length} Questions',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(height: 40.h),
                // Animated start button
                AnimatedButton(
                  onPressed: () {
                    context.push(Routes.questionsScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
