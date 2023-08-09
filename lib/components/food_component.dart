import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';

import 'package:parallax06/components/food.dart';
import 'package:parallax06/main.dart';
import 'package:parallax06/utils/helper.dart';

class FoodComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  FoodPreSprite foodPreSprite;

  int factX = 0, factY = 0;

  late double screenWidth, screenHeight;

  CircleHitbox hitbox = CircleHitbox();

  FoodComponent({required this.foodPreSprite}) : super() {
    debugMode = true;
    size = Vector2.all(50);
    // scale = Vector2.all(.5);
  }

  @override
  FutureOr<void> onLoad() {
    _initPosition();

    sprite = foodPreSprite.food.sprite;

    add(hitbox);

    return super.onLoad();
  }

  _initPosition() {
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;

    Random random = Random();

    // verificar lado de incidencia
    if (foodPreSprite.sideType == SideType.up) {
      factY = 1;
    } else if (foodPreSprite.sideType == SideType.down) {
      factY = -1;
    }
    if (foodPreSprite.sideType == SideType.left) {
      factX = 1;
    }
    if (foodPreSprite.sideType == SideType.right) {
      factX = -1;
    }

    // init position
    if (foodPreSprite.sideType == SideType.up ||
        foodPreSprite.sideType == SideType.down) {
      // Y
      // position = Vector2(
      //     screenWidth * 0.99 /* 0 */ , factY == 1 ? 0 : screenHeight); // TEXT EXTREMOS
      position = Vector2(
          random.nextDouble() * screenWidth, factY == 1 ? 0 : screenHeight);

      if (position.x > (screenWidth - size.x / 2)) {
        // muy pegado a la derecha, no es visible correctamente
        position.x = screenWidth - size.x;
      }
    } else {
      // X
      // position = Vector2(
      // factX == 1 ? 0 : screenWidth, /*0*/ screenHeight); // TEST EXTREMOS
      position = Vector2(
          factX == 1 ? 0 : screenWidth, random.nextDouble() * screenHeight);
      if (position.y > (screenHeight - size.y / 2)) {
        // muy pegado abajo, no es visible correctamente
        position.y = screenHeight - size.y;
      }
    }
  }

  @override
  void update(double dt) {
    if (gameRef.resetGame) {
      removeFromParent();
    }

    position.add(Vector2(
        foodPreSprite.speed * dt * factX, foodPreSprite.speed * dt * factY));

    if (foodPreSprite.sideType == SideType.up && position.y > screenHeight) {
      removeFromParent();
      game.lostFood++;
      game.refreshStatistics(false);
    } else if (foodPreSprite.sideType == SideType.down &&
        position.y < -size.y) {
      removeFromParent();
      game.lostFood++;
      game.refreshStatistics(false);
    } else if (foodPreSprite.sideType == SideType.left &&
        position.x > screenWidth) {
      removeFromParent();
      game.lostFood++;
      game.refreshStatistics(false);
    }
    if (foodPreSprite.sideType == SideType.right && position.x < -size.x) {
      removeFromParent();
      game.lostFood++;
      game.refreshStatistics(false);
    }

    super.update(dt);
  }
}
