class Question {
  final String _choiceA;
  final String _choiceB;
  final String _choiceC;
  final String _choiceD;
  final String _questionText;
  final String _correctChoice; // "A", "B"

  Question(
    this._questionText,
    this._choiceA,
    this._choiceB,
    this._choiceC,
    this._choiceD,
    this._correctChoice,
  );

  String get choiceA => _choiceA;
  String get choiceB => _choiceB;
  String get choiceC => _choiceC;
  String get choiceD => _choiceD;
  String get questionText => _questionText;
  String get correctChoice => _correctChoice;
}
