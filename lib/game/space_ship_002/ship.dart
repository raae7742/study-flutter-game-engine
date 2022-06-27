import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp/game_engine.dart';

typedef FireCallback = void Function(bool activated);

const SHIP_SIZE = 60.0;

class Ship extends GameControl {

  final FireCallback onFire;

  Ship({required this.onFire});

  @override
  void onStart(Canvas canvas, Size size, int current) {
    width = SHIP_SIZE;
    height = SHIP_SIZE;
    x = (size.width - width) / 2;
    y = 500;
    paint.color = Colors.blue;
  }

  @override
  void tick(Canvas canvas, Size size, int current, int term) {
    x = x + _direction;
    canvas.drawCircle(Offset( x + SHIP_SIZE / 2, y + SHIP_SIZE / 2 ), SHIP_SIZE / 2, paint);
  }

  bool checkCollisionAndExplode(GameControl target) {
    var result = checkCollision(target);
    if (result) deleted = true;
    return result;
  }

  @override
  void onHorizontalDragStart(DragStartDetails details) {
    onFire(true);
  }

  @override
  void onHorizontalDragEnd(DragEndDetails details) {
    onFire(false);
  }

  void move(int direction) {
    _direction = direction;
  }

  int _direction = 0;
}