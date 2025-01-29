import 'package:quiz_app/features/quiz/data/models/quiz_option.dart';

class QuizModel {
  final int id;
  final String title;
  final String? imageUrl;
  final String correctAnswer;
  List<QuizOption> quizOptions = [];

  QuizModel({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.correctAnswer,
    required this.quizOptions,
  });
}
