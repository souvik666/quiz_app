import 'package:flutter/material.dart';
import 'dart:math';

class CustomOverlay extends StatefulWidget {
  final bool _isCorrect;
  CustomOverlay(this._isCorrect);

  @override
  _CustomOverlayState createState() => _CustomOverlayState();
}

class _CustomOverlayState extends State<CustomOverlay>
    with SingleTickerProviderStateMixin {
  Animation _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: widget._isCorrect ? Colors.green : Colors.red,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                  width: double.infinity,
                  child: Transform.rotate(
                      angle: _iconAnimation.value * 2 * pi,
                      child: new Icon(
                          widget._isCorrect ? Icons.done : Icons.clear,
                          size: _iconAnimation.value * 50.0,
                          color: Colors.white)))
            ]));
  }
}
