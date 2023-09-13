import 'dart:async';
import 'package:flame/parallax.dart';

import 'package:flame/components.dart';

class CandyBackground extends ParallaxComponent {
  @override
  FutureOr<void> onLoad() async {
    parallax = await game.loadParallax([
      ParallaxImageData('layer06_sky.png'),
      ParallaxImageData('layer05_rocks.png'),
      ParallaxImageData('layer04_clouds.png'),
      ParallaxImageData('layer03_trees.png'),
      ParallaxImageData('layer02_cake.png'),
      ParallaxImageData('layer01_ground.png'),
    ], baseVelocity: Vector2(5, 0), velocityMultiplierDelta: Vector2(1.6, 0));

    return super.onLoad();
  }
}
