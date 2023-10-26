import 'dart:async';
import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';

import 'package:flame_audio/flame_audio.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:gamepads/gamepads.dart';

import 'package:parallax06/components/character.dart';
import 'package:parallax06/components/food_component.dart';
import 'package:parallax06/main.dart';
import 'package:parallax06/utils/create_animation_by_limit.dart';
import 'package:parallax06/utils/helper.dart';

class PlayerComponent extends Character with HasGameReference<MyGame> {
  double changeAnimatimationTimer = 0;
  double timeToChangeAnimation = 0;
  bool chewing = false;

  late AudioPlayer audioPlayerChewing;

  final double _maxVelocity = 5.0;

  PlayerComponent() : super() {
    FlameAudio.loop('chewing.wav', volume: 0).then((audioPlayer) {
      audioPlayerChewing = audioPlayer;
    });
    _init();
  }

  _init() {
    anchor = Anchor.center;
    debugMode = true;
    position = Vector2(spriteSheetWidth, spriteSheetHeight);
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    // scale = Vector2.all(.5);
  }

  reset() {
    _init();
    changeAnimatimationTimer = 0;
    timeToChangeAnimation = 0;
    chewing = false;
    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (chewing) {
      changeAnimatimationTimer += dt;
      if (changeAnimatimationTimer >= timeToChangeAnimation) {
        timeToChangeAnimation = 0;
        changeAnimatimationTimer = 0;
        chewing = false;
        animation = idleAnimation;
        // audioPlayerChewing.setVolume(0);
        audioPlayerChewing.stop();
      }
    }
    _movePlayerJoystick(dt);
    _movePlayer(dt);
  }

  @override
  void onRemove() {
    audioPlayerChewing.dispose();
    super.onRemove();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.isEmpty) {
      movementType = MovementType.idle;
    }

    // movement
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      movementType = MovementType.right;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      movementType = MovementType.left;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
      movementType = MovementType.up;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      movementType = MovementType.down;
    }

    // rotation
    if (keysPressed.contains(LogicalKeyboardKey.keyR)) {
      switch (sideType) {
        case SideType.right:
          sideType = SideType.down;
          break;
        case SideType.down:
          sideType = SideType.left;
          break;
        case SideType.left:
          sideType = SideType.up;
          break;
        case SideType.up:
          sideType = SideType.right;
          break;
      }

      _rotate();
    }

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  FutureOr<void> onLoad() async {
    // var gamepads = await Gamepads.list();
    // print('*******');
    // print(gamepads.toString());

    Gamepads.events.listen((GamepadEvent event) {
      // print("gamepadId" + event.gamepadId);
      // print("timestamp" + event.timestamp.toString());
      // print("type   " + event.type.toString());
      // print("key   " + event.key.toString());
      // print("value   " + event.value.toString());

      if (event.key == 'button-0' && event.value == 1.0) {
        // print('Rotate');
        _rotate();
      } else if (event.key == 'pov' && event.value == 0) {
        // up
        // print('up');
        movementType = MovementType.up;
      } else if (event.key == 'pov' && event.value == 4500) {
        // up right
        // print('up right');
      } else if (event.key == 'pov' && event.value == 9000) {
        // right
        // print('right');
        movementType = MovementType.right;
      } else if (event.key == 'pov' && event.value == 13500) {
        // buttom right
        // print('buttom right');
      } else if (event.key == 'pov' && event.value == 18000) {
        //bottom
        // print('bottom');
        movementType = MovementType.down;
      } else if (event.key == 'pov' && event.value == 22500) {
        // buttom left
        // print('buttom left');
      } else if (event.key == 'pov' && event.value == 27000) {
        // left
        // print('left');
        movementType = MovementType.left;
      } else if (event.key == 'pov' && event.value == 31500) {
        // top left
        // print('top left');
      } else {
        movementType = MovementType.idle;
        //
      }
    });

    final spriteImage = await Flame.images.load('player.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    chewAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 2, stepTime: .08);

    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 1, sizeX: 2, stepTime: .08);

    animation = idleAnimation;

    body = RectangleHitbox();
    mouth = RectangleHitbox(size: Vector2(100, 80), position: Vector2(110, 70));

    game.hudComponent.rotateButton.onPressed = _rotate;

    add(body);
    add(mouth);

    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (mouth.isColliding &&
        other is FoodComponent &&
        !chewing &&
        sideType == other.foodPreSprite.sideType) {
      other.removeFromParent();

      chewing = true;
      animation = chewAnimation;
      timeToChangeAnimation = other.foodPreSprite.food.chewed;

      // Statistics
      game.points += other.foodPreSprite.food.point;
      game.eatenFood++;
      game.refreshStatistics(true);

      audioPlayerChewing.setVolume(1);
      audioPlayerChewing.seek(const Duration(seconds: 0));
      audioPlayerChewing.resume();

      FlameAudio.play('eating.mp3');
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  void _movePlayerJoystick(double dt) {
    if (game.hudComponent.joystick.direction != JoystickDirection.idle) {
      // print(gameRef.hudComponent.joystick.delta);
      position.add(game.hudComponent.joystick.delta * dt * _maxVelocity);
    }
  }

  void _rotate() {
    if (sideType == SideType.left || sideType == SideType.right) {
      flipVertically();
    }

    angle += math.pi * 0.5;
  }

  void _movePlayer(double dt) {
    switch (movementType) {
      case MovementType.right:
      case MovementType.left:
        position.add(Vector2(
            dt * speed * (movementType == MovementType.left ? -1 : 1), 0));
        break;
      case MovementType.up:
      case MovementType.down:
        position.add(Vector2(
            0, dt * speed * (movementType == MovementType.up ? -1 : 1)));
        break;
      case MovementType.idle:
        break;
    }
  }
}
