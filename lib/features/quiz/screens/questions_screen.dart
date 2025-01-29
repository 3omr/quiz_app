import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/core/routing/routes.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_model.dart';
import 'package:quiz_app/features/quiz/logic/quiz_cubit.dart';
import 'package:quiz_app/features/quiz/logic/quiz_state.dart';
import 'package:quiz_app/features/quiz/screens/widgets/animated_button.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is QuizCompleted) {
          context.pushReplacement(
            Routes.answersSummaryScreen,
            extra: [
              state.quizQuestions,
              context.read<QuizCubit>().selectedAnswers
            ],
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quiz Questions',
            style: GoogleFonts.poppins(
              color: const Color(0xff36edbc),
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(color: Color(0xff36edbc)),
          backgroundColor: const Color(0xff1f1147),
          elevation: 0,
        ),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is QuizLoaded || state is QuizAnswered) {
              final cubit = context.read<QuizCubit>();
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value:
                          (cubit.currentQuestionIndex + 1) / cubit.quiz.length,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xff36edbc)),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: QuestionCard(
                        question: cubit.quiz[cubit.currentQuestionIndex],
                        selectedAnswer: cubit.selectedAnswers[
                            cubit.quiz[cubit.currentQuestionIndex].id],
                      ),
                    ),
                    if (state is QuizAnswered)
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: AnimatedButton(
                          onPressed: () => cubit.nextQuestion(),
                          label:
                              cubit.currentQuestionIndex < cubit.quiz.length - 1
                                  ? 'Continue'
                                  : 'Show Results',
                        ),
                      ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final QuizModel question;
  final int? selectedAnswer;

  const QuestionCard({
    super.key,
    required this.question,
    this.selectedAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();
    final isAnswered = selectedAnswer != null;
    Color? cardColor;

    if (isAnswered) {
      final isCorrect = question.correctAnswer ==
          question.quizOptions
              .firstWhere((element) => element.id == selectedAnswer)
              .option;
      cardColor = isCorrect ? Colors.green.shade800 : Colors.red.shade800;
    }

    return Card(
      color: cardColor ?? const Color(0xff6848fd),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: const Color(0xff36edbc).withOpacity(0.3),
          width: 1.5.w,
        ),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (question.imageUrl != null)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    question.imageUrl!,
                    width: double.infinity,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Text(
              question.title,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            ...question.quizOptions.map(
              (option) => RadioListTile<int>(
                title: Text(
                  option.option,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                value: option.id,
                groupValue: selectedAnswer,
                activeColor: const Color(0xff36edbc),
                onChanged: isAnswered
                    ? null
                    : (value) {
                        cubit.answerQuestion(question.id, value!);
                      },
              ),
            ),
            if (isAnswered)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  'Correct Answer: ${question.correctAnswer}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
