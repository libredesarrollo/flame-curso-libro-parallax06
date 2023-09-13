import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:parallax06/utils/helper.dart';

/* 
tipos de comidas que pudieran estar en el sprite sheet, en el 
sprite sheet de ejemplo aparecen solo dulces y pasteles
*/
enum TypeFood { bread, fruit, meat, candy, cake }

/* clase con las propiedades para definir un alimento/sprite por pantalla */
class Food {
  TypeFood typeFood;
  double chewed;
  Sprite sprite;
  int point;

  Food(
      {required this.typeFood,
      required this.chewed,
      required this.sprite,
      this.point = 1});
}

/* 
clase empleada por los niveles para definir el tiempo de aparicion en la pantalla 
El nombre de FoodPreSprite consiste en que esta clase es utilizada para (antes/pre)
de generar el sprite de comida
*/
class FoodPreSprite {
  Food food;
  double speed;
  SideType sideType;
  double timeToOtherFood;

  FoodPreSprite(
      {required this.food,
      required this.speed,
      required this.sideType,
      this.timeToOtherFood = 3});
}

// alimentos disponibles
List<Food> foods = [];

init() async {
  final spriteImage = await Flame.images.load('candies.png');
  final spriteSheet =
      SpriteSheet(image: spriteImage, srcSize: Vector2.all(512));

  foods = [
    Food(
        typeFood: TypeFood.cake,
        chewed: 1,
        point: 1,
        sprite: spriteSheet.getSprite(0, 0)),
    Food(
        typeFood: TypeFood.candy,
        chewed: 3,
        sprite: spriteSheet.getSprite(0, 1)),
    Food(
        typeFood: TypeFood.cake,
        chewed: 5,
        point: 10,
        sprite: spriteSheet.getSprite(0, 2)),
    Food(
        typeFood: TypeFood.cake,
        chewed: 2.5,
        sprite: spriteSheet.getSprite(0, 3)),
    Food(
        typeFood: TypeFood.cake,
        chewed: 5,
        sprite: spriteSheet.getSprite(1, 0)),
    Food(
        typeFood: TypeFood.candy,
        chewed: 5,
        point: 5,
        sprite: spriteSheet.getSprite(1, 1)),
    Food(
        typeFood: TypeFood.candy,
        chewed: 5,
        sprite: spriteSheet.getSprite(1, 2)),
    Food(
        typeFood: TypeFood.candy,
        chewed: 5,
        sprite: spriteSheet.getSprite(1, 3)),
  ];
}

// levels
List<FoodPreSprite> getCurrentLevel({int level = 1}) {
  switch (level) {
    case 2:
      return [
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[0], sideType: SideType.down, speed: 60),
        FoodPreSprite(food: foods[2], sideType: SideType.left, speed: 100),
        FoodPreSprite(food: foods[4], sideType: SideType.right, speed: 50),
        FoodPreSprite(food: foods[5], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[1], sideType: SideType.down, speed: 40),
        FoodPreSprite(food: foods[3], sideType: SideType.left, speed: 45),
        FoodPreSprite(food: foods[7], sideType: SideType.right, speed: 25),
        FoodPreSprite(food: foods[2], sideType: SideType.left, speed: 100),
        FoodPreSprite(food: foods[4], sideType: SideType.right, speed: 50),
      ];
    case 3:
      return [
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[0], sideType: SideType.down, speed: 60),
        FoodPreSprite(food: foods[2], sideType: SideType.left, speed: 100),
        FoodPreSprite(food: foods[4], sideType: SideType.right, speed: 50),
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[1], sideType: SideType.down, speed: 40),
        FoodPreSprite(food: foods[7], sideType: SideType.left, speed: 45),
        FoodPreSprite(food: foods[3], sideType: SideType.right, speed: 25),
        FoodPreSprite(food: foods[3], sideType: SideType.left, speed: 45),
        FoodPreSprite(food: foods[8], sideType: SideType.right, speed: 25),
      ];
    case 4:
      return [
        FoodPreSprite(food: foods[2], sideType: SideType.left, speed: 100),
        FoodPreSprite(food: foods[4], sideType: SideType.right, speed: 50),
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[2], sideType: SideType.down, speed: 60),
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50)
      ];
    case 5:
      return [
        FoodPreSprite(food: foods[0], sideType: SideType.down, speed: 60),
        FoodPreSprite(food: foods[3], sideType: SideType.right, speed: 25),
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[4], sideType: SideType.right, speed: 50),
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[1], sideType: SideType.down, speed: 40),
        FoodPreSprite(food: foods[2], sideType: SideType.left, speed: 100),
        FoodPreSprite(food: foods[3], sideType: SideType.left, speed: 45),
      ];
    case 6:
      return [
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[1], sideType: SideType.down, speed: 60),
        FoodPreSprite(food: foods[2], sideType: SideType.left, speed: 100),
        FoodPreSprite(food: foods[4], sideType: SideType.right, speed: 50),
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[1], sideType: SideType.down, speed: 40),
        FoodPreSprite(food: foods[3], sideType: SideType.left, speed: 45),
        FoodPreSprite(food: foods[3], sideType: SideType.right, speed: 25),
      ];
    default: // 1
      return [
        FoodPreSprite(food: foods[0], sideType: SideType.up, speed: 50),
        FoodPreSprite(food: foods[1], sideType: SideType.down, speed: 60),
        FoodPreSprite(food: foods[2], sideType: SideType.left, speed: 100)
      ];
  }
}
