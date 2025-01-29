import 'package:quiz_app/features/quiz/data/models/quiz_model.dart';

abstract class QuizState {
  const QuizState();
}

class QuizInitial extends QuizState {
  const QuizInitial();
}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuizModel> quizQuestions;
  final int currentQuestionIndex;

  const QuizLoaded(this.quizQuestions, this.currentQuestionIndex);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuizLoaded &&
        other.quizQuestions == quizQuestions &&
        other.currentQuestionIndex == currentQuestionIndex;
  }

  @override
  int get hashCode => quizQuestions.hashCode ^ currentQuestionIndex.hashCode;
}

class QuizAnswered extends QuizState {
  final List<QuizModel> quizQuestions;
  final int questionIndex;
  final bool isCorrect;

  const QuizAnswered(this.quizQuestions, this.questionIndex, this.isCorrect);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuizAnswered &&
        other.quizQuestions == quizQuestions &&
        other.questionIndex == questionIndex &&
        other.isCorrect == isCorrect;
  }

  @override
  int get hashCode =>
      quizQuestions.hashCode ^ questionIndex.hashCode ^ isCorrect.hashCode;
}

class QuizCompleted extends QuizState {
  final List<QuizModel> quizQuestions;
  final int score;
  final int totalQuestions;

  const QuizCompleted(this.quizQuestions, this.score, this.totalQuestions);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuizCompleted &&
        other.quizQuestions == quizQuestions &&
        other.score == score &&
        other.totalQuestions == totalQuestions;
  }

  @override
  int get hashCode =>
      quizQuestions.hashCode ^ score.hashCode ^ totalQuestions.hashCode;
}

class QuizError extends QuizState {
  final String errorMessage;

  const QuizError(this.errorMessage);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuizError && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class QuizRestart extends QuizState {
  const QuizRestart();
}
