import 'package:flutter/material.dart';
import 'package:temp/game/space_ship_002/missiles.dart';
import '../../game_engine.dart';
import 'asteroids.dart';
import 'joystick.dart';
import 'ship.dart';

class SpaceShip extends StatelessWidget {
  SpaceShip({Key? key}) : super(key: key) {
    _joystick = Joystick(
        onMove: (int direction) => {
          _ship.move(direction)
        }
    );

    _missiles = Missiles();
    _ship = Ship(
        onFire: (bool activated) {
          _missiles.fire(_ship.x + (_ship.width - 10)/2, _ship.y, activated);
        });
    _asteroids = Asteroids(
      onCheckCollision: (GameControl target) {
        return _ship.checkCollisionAndExplode(target);
      }
    );

    _gameEngine.getControls().addControl(_joystick);
    _gameEngine.getControls().addControl(_ship);
    _gameEngine.getControls().addControl(_asteroids);
    _gameEngine.getControls().addControl(_missiles);
    _gameEngine.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("GameEngine Demo"),
        ),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: _gameEngine.getCustomPaint()
        )
    );
  }

  final _gameEngine = GameEngine();
  late final _joystick;
  late final _ship;
  late final _asteroids;
  late final _missiles;
}

