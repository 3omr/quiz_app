import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/core/routing/routes.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_model.dart';
import 'package:quiz_app/features/quiz/screens/widgets/animated_button.dart';

class AnswersSummaryScreen extends StatelessWidget {
  final List<QuizModel> questions;
  final Map<int, int?> selectedAnswers;

  const AnswersSummaryScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final correctAnswers = questions.where((q) {
      final selected = selectedAnswers[q.id];
      return selected != null &&
          q.quizOptions.firstWhere((o) => o.id == selected).option ==
              q.correctAnswer;
    }).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Answers Summary',
          style: GoogleFonts.poppins(
            color: const Color(0xff36edbc),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xff1f1147),
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final selectedId = selectedAnswers[question.id];
                  final isCorrect = selectedId != null &&
                      question.quizOptions
                              .firstWhere((o) => o.id == selectedId)
                              .option ==
                          question.correctAnswer;

                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      color: const Color(0xff6848fd),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isCorrect ? Colors.green : Colors.red,
                        width: 2.w,
                      ),
                    ),
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Your answer: ${selectedId != null ? question.quizOptions.firstWhere((o) => o.id == selectedId).option : 'Not answered'}',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          'Correct answer: ${question.correctAnswer}',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: AnimatedButton(
                onPressed: () {
                  context.pushReplacement(
                    Routes.resultsScreen,
                    extra: [
                      questions.length,
                      correctAnswers,
                    ],
                  );
                },
                label: 'Final Results',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
