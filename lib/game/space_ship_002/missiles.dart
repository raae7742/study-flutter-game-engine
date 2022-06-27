import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:temp/game_engine.dart';

import 'asteroids.dart';

class Missiles extends GameControl {

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    if(_activated == false) return;

    _term = _term + term;
    while (_term >= _relaseInterval) {
      _term = _term - _relaseInterval;
      _createMissile();
    }
  }

  void _createMissile() {
    getGameControlGroup()?.addControl(Missile(_fireX, _fireY));
  }

  void fire (double x, double y, bool activated) {
    _fireX = x;
    _fireY = y;
    _activated = activated;
  }

  bool _activated = false;
  var _term = 0;
  var _relaseInterval = 100;
  var _fireX = 0.0;
  var _fireY = 0.0;
}

class Missile extends GameControl {
  Missile(double fireX, double fireY) {
    x = fireX - 5;
    y = fireY - 5;
    paint.color = Colors.black;
  }

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    y = y - _speed;
    if (y < -10) {
      deleted = true;
      return;
    }

    canvas.drawCircle(Offset( x , y ), 5, paint);

    checkCollisions().forEach((element) {
      if( element is Asteroid ) {
        deleted = true;
        element.deleted = true;
      }
    });
  }

  double _speed = 4;
}