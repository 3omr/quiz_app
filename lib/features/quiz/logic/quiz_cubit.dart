import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_model.dart';
import 'package:quiz_app/features/quiz/data/quiz_data.dart';
import 'package:quiz_app/features/quiz/logic/quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(const QuizInitial());

  List<QuizModel> quiz = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  Map<int, int?> selectedAnswers = {};

  Future<void> loadQuiz() async {
    emit(QuizLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      _resetQuizData();
      quiz = QuizData.quiz;
      emit(QuizLoaded(quiz, 0));
    } catch (e) {
      emit(QuizError('Failed to load quiz: ${e.toString()}'));
    }
  }

  void answerQuestion(int questionId, int selectedId) {
    final previousAnswer = selectedAnswers[questionId];
    selectedAnswers[questionId] = selectedId;

    final currentQuestion = quiz[currentQuestionIndex];
    final isCorrect = _checkAnswerCorrectness(currentQuestion, selectedId);

    _updateScore(previousAnswer, currentQuestion, isCorrect);
    emit(QuizAnswered(quiz, currentQuestionIndex, isCorrect));
  }

  void nextQuestion() {
    if (currentQuestionIndex < quiz.length - 1) {
      currentQuestionIndex++;
      emit(QuizLoaded(quiz, currentQuestionIndex));
    } else {
      emit(QuizCompleted(quiz, correctAnswers, quiz.length));
    }
  }

  void resetQuiz() {
    _resetQuizData();
    emit(const QuizRestart());
  }

  // ---- Helper Methods ----
  bool _checkAnswerCorrectness(QuizModel question, int selectedId) {
    return question.correctAnswer ==
        question.quizOptions.firstWhere((o) => o.id == selectedId).option;
  }

  void _updateScore(int? previousAnswer, QuizModel question, bool isCorrect) {
    if (previousAnswer != null) {
      final wasCorrect = _checkAnswerCorrectness(question, previousAnswer);
      if (wasCorrect) correctAnswers--;
    }
    if (isCorrect) correctAnswers++;
  }

  void _resetQuizData() {
    currentQuestionIndex = 0;
    correctAnswers = 0;
    selectedAnswers.clear();
  }
}
