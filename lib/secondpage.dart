import 'package:flutter/material.dart';
import 'quizsecond.dart';

class ScorePage extends StatelessWidget {
  final int _score;
  final int _totalQuestion;
  ScorePage(this._score, this._totalQuestion);

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.fill)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("SCORE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                )),
            new Text(_score.toString() + "/" + _totalQuestion.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                )),
            new IconButton(
                icon: Icon(Icons.refresh),
                iconSize: 80.0,
                color: Colors.white,
                onPressed: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => QuizSecondApp())))
          ]),
    ));
  }
}
