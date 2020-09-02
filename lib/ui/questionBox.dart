import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  final Color _btnColor;
  final String _btnText;
  final String _choiceText;
  final bool isButtonDisabled;
  final VoidCallback _onPressed;

  QuestionBox(this._btnColor, this._btnText, this._choiceText, this._onPressed,
      this.isButtonDisabled);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          border: Border.all(width: 1.0, color: Colors.black87),
          borderRadius: BorderRadius.all(
            const Radius.circular(4.0),
          ),
        ),
        margin: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                child: Center(
                    child: Text(
                  _choiceText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ))),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: RaisedButton(
                  onPressed: () => (isButtonDisabled) ? null : _onPressed(),
                  color: _btnColor,
                  child: Text(_btnText,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0))),
            )
          ],
        ),
      ),
    );
  }
}
