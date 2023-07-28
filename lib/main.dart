import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:parallax06/background/candy_background.dart';
import 'package:parallax06/components/food_component.dart';
import 'package:parallax06/components/player_component.dart';
import 'package:parallax06/components/food.dart' as food;
import 'package:parallax06/overlay/game_over_overlay.dart';
import 'package:parallax06/overlay/level_selection_overlay.dart';
import 'package:parallax06/overlay/statistics_overlay.dart';
import 'package:parallax06/overlay/type_game_overlay.dart';
import 'package:parallax06/utils/type_game.dart' as typegame;

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  double foodTimer = 0.0;
  int foodIndex = 0;

  int points = 0;
  int eatenFood = 0;
  int lostFood = 0;

  int currentLevel = 1;
  typegame.TypeGame typeGame = typegame.TypeGame.byPoints;
  late PlayerComponent _playerComponent;

  loadLevel(
      {bool dead = false,
      int currentLevel = 1,
      typegame.TypeGame typeGame = typegame.TypeGame.byPoints}) {
    paused = false;
    foodTimer = 0;
    foodIndex = 0;

    points = 0;
    eatenFood = 0;
    lostFood = 0;

    this.currentLevel = currentLevel;
    this.typeGame = typeGame;

    _playerComponent.reset();

    overlays.remove('GameOver');
    overlays.remove('Statistics');
    overlays.add('Statistics');
  }

  refreshStatistics(bool isEaten) {
    overlays.remove('Statistics');
    overlays.add('Statistics');

    _checkEndGame(isEaten);
  }

  void _checkEndGame(bool isEaten) {
    typegame.StateGame stateGame = typegame.StateGame.running;

    switch (typeGame) {
      case typegame.TypeGame.oneLost:
        stateGame = typegame.oneLost(
            food.getCurrentLevel(level: currentLevel), eatenFood, lostFood);
        break;
      case typegame.TypeGame.byPoints:
        stateGame = typegame.byPoints(food.getCurrentLevel(level: currentLevel),
            points, eatenFood, lostFood, 1);
        break;
      case typegame.TypeGame.onlyTypeFood:
        stateGame = typegame.onlyTypeFood(
            food.getCurrentLevel(level: currentLevel),
            foodIndex,
            currentLevel,
            eatenFood,
            lostFood,
            isEaten);
        break;
      case typegame.TypeGame.notEatenThisFood:
        stateGame = typegame.notEatenThisFood(
            food.getCurrentLevel(level: currentLevel),
            foodIndex,
            currentLevel,
            eatenFood,
            lostFood,
            isEaten);
        break;
    }

    switch (stateGame) {
      case typegame.StateGame.lose:
        paused = true;
        print("losing");
        loadLevel(
            /*currentLevel: currentLevel , */ typeGame: typeGame, dead: true);
        overlays.add('GameOver');
        break;
      case typegame.StateGame.win:
        paused = true;
        print("win");
        loadLevel(currentLevel: currentLevel + 1, typeGame: typeGame);
        overlays.add('GameOver');
        break;
      default:
        break;
    }
  }

  String typeGameDetail() {
    String meta = '';

    switch (typeGame) {
      case typegame.TypeGame.oneLost:
        meta = typegame.oneLostMetadata();
        break;
      case typegame.TypeGame.byPoints:
        meta = typegame.byPointsMetadata(currentLevel);
        break;
      case typegame.TypeGame.notEatenThisFood:
        meta = typegame.notEatenThisFoodMetadata(currentLevel);
        break;
      case typegame.TypeGame.onlyTypeFood:
        meta = typegame.onlyTypeFoodMetadata(currentLevel);
        break;
    }

    return "$typeGame $meta";
  }

  @override
  FutureOr<void> onLoad() async {
    // add(await bgParallax());
    await food.init();
    _playerComponent = PlayerComponent();
    add(CandyBackground());
    add(_playerComponent);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _addSpriteFoodToWindow(dt);
    super.update(dt);
  }

  _addSpriteFoodToWindow(double dt) {
    if (foodIndex < food.getCurrentLevel(level: currentLevel).length) {
      if (foodTimer >=
          food
              .getCurrentLevel(level: currentLevel)[foodIndex]
              .timeToOtherFood) {
        add(FoodComponent(
            foodPreSprite:
                food.getCurrentLevel(level: currentLevel)[foodIndex]));
        foodIndex++;
        foodTimer = 0;
      }
      foodTimer += dt;
    }
  }

  // Future<ParallaxComponent> bgParallax() async {
  //   ParallaxComponent parallaxComponent = await loadParallaxComponent([
  //     ParallaxImageData('layer06_sky.png'),
  //     ParallaxImageData('layer05_rocks.png'),
  //     ParallaxImageData('layer04_clouds.png'),
  //     ParallaxImageData('layer03_trees.png'),
  //     ParallaxImageData('layer02_cake.png'),
  //     ParallaxImageData('layer01_ground.png'),
  //   ], baseVelocity: Vector2(5, 0), velocityMultiplierDelta: Vector2(1.6, 0));

  //   return parallaxComponent;
  // }
}

void main() {
  runApp(GameWidget(
    game: MyGame(),
    overlayBuilderMap: {
      'Statistics': (context, MyGame game) {
        return StatisticsOverlay(game: game);
      },
      'GameOver': (context, MyGame game) {
        return GameOverOverlay(game: game);
      },
      'LevelSelection': (context, MyGame game) {
        return LevelSelectionOverlay(game: game);
      },
      'TypeGame': (context, MyGame game) {
        return TypeGameOverlay(game: game);
      }
    },
    initialActiveOverlays: const ['Statistics'],
  ));
}
