import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/core/binding/di.dart';
import 'package:quiz_app/core/routing/routes.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_model.dart';
import 'package:quiz_app/features/quiz/logic/quiz_cubit.dart';
import 'package:quiz_app/features/quiz/screens/answers_summary_screen.dart';
import 'package:quiz_app/features/quiz/screens/questions_screen.dart';
import 'package:quiz_app/features/quiz/screens/quiz_screen.dart';
import 'package:quiz_app/features/quiz/screens/results_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.quizScreen,
    routes: [
      GoRoute(
        path: Routes.quizScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<QuizCubit>(),
          child: const QuizScreen(),
        ),
      ),
      GoRoute(
        path: Routes.questionsScreen,
        builder: (context, state) => BlocProvider.value(
          value: getIt<QuizCubit>(),
          child: const QuestionsScreen(),
        ),
      ),
      GoRoute(
        path: Routes.answersSummaryScreen,
        builder: (context, state) {
          List provided = state.extra! as List;
          List<QuizModel> questions = provided[0];
          Map<int, int?> selectedAnswers = provided[1];

          return BlocProvider.value(
            value: getIt<QuizCubit>(),
            child: AnswersSummaryScreen(
              questions: questions,
              selectedAnswers: selectedAnswers,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.resultsScreen,
        builder: (context, state) {
          List provided = state.extra! as List;
          int totalQuestions = provided[0];
          int correctAnswers = provided[1];

          return BlocProvider.value(
            value: getIt<QuizCubit>(),
            child: ResultsScreen(
              totalQuestions: totalQuestions,
              correctAnswers: correctAnswers,
            ),
          );
        },
      ),
    ],
  );
}
