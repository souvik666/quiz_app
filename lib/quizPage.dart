import 'package:flutter/material.dart';
import 'package:quiz_app/secondpage.dart';
import 'package:quiz_app/ui/overlay.dart';
import 'package:quiz_app/ui/questionBox.dart';
import 'dart:async';
import 'utils/questionList.dart';
import 'quiz.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Results _currentQuestion;
  QuestionList _quizQuestions;
  bool _isLoading;

  @override
  initState() {
    super.initState();
    _isLoading = true;
    fetchQuestions();
  }

  Quiz quiz;
  List<Results> results;

  Future<void> fetchQuestions() async {
    var res = await http.get('https://opentdb.com/api.php?amount=20');
    var decRes = jsonDecode(res.body);

    quiz = Quiz.fromJson(decRes);
    results = quiz.results;

    _quizQuestions = new QuestionList(results.toList());

    if (res.statusCode > 100) {
      init();
    }
    setState(() {
      _isLoading = false;
    });
  }

  bool _isButtonDisabled = false;
  int _questionNumber = 0;
  int _score = 0;
  bool _overlayVisible;
  bool _isCorrect;

  void init() {
    _overlayVisible = false;
    _isButtonDisabled = false;
    _currentQuestion = _quizQuestions.nextQuestion;
    _questionNumber = _quizQuestions.questionNumber;
  }

  void choiceHandler(String choice) {
    _isCorrect = (choice == _currentQuestion.correctAnswer);
    _score = (_isCorrect) ? _score + 1 : _score;

    if (_questionNumber == _quizQuestions.length) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  ScorePage(_score, _quizQuestions.length))));
    }
    print(choice);
    print(_currentQuestion.correctAnswer);

    print(_score);
    this.setState(() {
      _isButtonDisabled = true;
      _overlayVisible = true;
    });

    Timer(
        Duration(seconds: 3),
        () => this.setState(() {
              init();
            }));
  }

  Column createQuizQuestion(Results obj) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          children: <Widget>[
            new QuestionBox(Colors.red, "A", obj.allAnswers[0], () {
              choiceHandler(obj.allAnswers[0]);
            }, _isButtonDisabled),
            new QuestionBox(Colors.red, "B", obj.allAnswers[1], () {
              choiceHandler(obj.allAnswers[1]);
            }, _isButtonDisabled)
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: _currentQuestion.type.startsWith('m')
            ? Row(
                children: <Widget>[
                  new QuestionBox(Colors.red, "C", obj.allAnswers[2], () {
                    choiceHandler(obj.allAnswers[2]);
                  }, _isButtonDisabled),
                  new QuestionBox(Colors.red, "D", obj.allAnswers[3], () {
                    choiceHandler(obj.allAnswers[3]);
                  }, _isButtonDisabled)
                ],
              )
            : Container(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz Pages",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: (_isLoading)
              ? new Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                )
              : Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/bg.jpg'),
                              fit: BoxFit.fill)),
                      child: Text(""),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Container(
                              color: Color(0x476879FF),
                              width: double.infinity,
                              padding:
                                  new EdgeInsets.only(top: 30.0, bottom: 10.0),
                              child: Center(
                                child: Text(
                                    "QUESTION " + _questionNumber.toString(),
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.black54),
                              padding: EdgeInsets.only(
                                  top: 10.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0),
                              child: Text(_currentQuestion.question,
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: createQuizQuestion(_currentQuestion),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _overlayVisible
                                ? new CustomOverlay(_isCorrect)
                                : null,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
    );
  }
}
