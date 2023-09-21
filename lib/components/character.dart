import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:parallax06/utils/helper.dart';

enum MovementType { idle, right, left, up, down }

class Character extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks {
  double speed = 500;

  final double spriteSheetWidth = 231;
  final double spriteSheetHeight = 230;

  late SpriteAnimation idleAnimation, chewAnimation;

  late RectangleHitbox body, mouth;

  MovementType movementType = MovementType.idle;
  SideType sideType = SideType.left;
}
