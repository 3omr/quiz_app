import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_model.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_option.dart';
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
      quiz = [
        QuizModel(
          title:
              'A 67-year-old smoker with chest pain. The ECG shows a positive wave when the depolarization wave moves towards the positive pole.',
          quizOptions: [
            const QuizOption(
                option:
                    'Depolarization wave spreads towards the +ve pole of the lead.',
                id: 1),
            const QuizOption(
                option:
                    'Depolarization wave spreads towards the -ve pole of the lead.',
                id: 2),
            const QuizOption(
                option:
                    'Depolarization wave spreads towards the +ve pole of the lead.',
                id: 3),
            const QuizOption(
                option:
                    'Depolarization wave spreads towards the -ve pole of the lead.',
                id: 4),
          ],
          correctAnswer:
              'Depolarization wave spreads towards the -ve pole of the lead.',
          id: 1,
        ),
        QuizModel(
          title: 'What is Flutter?',
          imageUrl: 'https://i.ibb.co/j6zQybt/image.png',
          quizOptions: [
            const QuizOption(option: 'Programming language', id: 1),
            const QuizOption(option: 'Development framework', id: 2),
            const QuizOption(option: 'Design tool', id: 3),
            const QuizOption(option: 'Database', id: 4),
          ],
          correctAnswer: 'Development framework',
          id: 2,
        ),
        QuizModel(
          title: 'What is Flutter?',
          imageUrl: 'https://i.ibb.co/j6zQybt/image.png',
          quizOptions: [
            const QuizOption(option: 'Programming language', id: 1),
            const QuizOption(
                option:
                    'Development framework, Development framework, Development framework',
                id: 2),
            const QuizOption(option: 'Design tool', id: 3),
            const QuizOption(option: 'Database', id: 4),
          ],
          correctAnswer: 'Development framework',
          id: 6,
        ),
        QuizModel(
          title: 'What is Flutter?',
          imageUrl: 'https://i.ibb.co/j6zQybt/image.png',
          quizOptions: [
            const QuizOption(option: 'Programming language', id: 1),
            const QuizOption(
                option:
                    'Development framework, Development framework, Development framework',
                id: 2),
            const QuizOption(option: 'Design tool', id: 3),
            const QuizOption(option: 'Database', id: 4),
          ],
          correctAnswer: 'Development framework',
          id: 3,
        ),
        QuizModel(
          title: 'What is Flutter?',
          imageUrl: 'https://i.ibb.co/j6zQybt/image.png',
          quizOptions: [
            const QuizOption(option: 'Programming language', id: 1),
            const QuizOption(
                option:
                    'Development framework, Development framework, Development framework',
                id: 2),
            const QuizOption(option: 'Design tool', id: 3),
            const QuizOption(option: 'Database', id: 4),
          ],
          correctAnswer: 'Development framework',
          id: 4,
        ),
        QuizModel(
          title: 'What is Flutter?',
          imageUrl: 'https://i.ibb.co/j6zQybt/image.png',
          quizOptions: [
            const QuizOption(option: 'Programming language', id: 1),
            const QuizOption(
                option:
                    'Development framework, Development framework, Development framework',
                id: 2),
            const QuizOption(option: 'Design tool', id: 3),
            const QuizOption(option: 'Database', id: 4),
          ],
          correctAnswer: 'Development framework',
          id: 5,
        ),
      ];

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
