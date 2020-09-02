import '../quiz.dart';

class QuestionList {
  final List<Results> _quizQuestionList;
  int _currentQuestionIndex = -1;
  QuestionList(this._quizQuestionList);

  int get length => _quizQuestionList.length;
  int get questionNumber => _currentQuestionIndex + 1;

  Results get nextQuestion {
    _currentQuestionIndex++;

    if (_currentQuestionIndex > length) {
      return null;
    }

    return _quizQuestionList[_currentQuestionIndex];
  }
}
