import 'package:parallax06/components/food.dart';

enum StateGame { running, win, lose }

enum TypeGame { oneLost, byPoints, onlyTypeFood, notEatenThisFood }

// tipo de juego que se termina cuando el player pierde un dulce
StateGame oneLost(List<FoodPreSprite> levelN, int eatenFood,
    int lostFood /*, bool isEaten*/) {
  // if (!isEaten) return StateGame.lose;
  if (lostFood >= 1) return StateGame.lose;
  if (levelN.length == eatenFood) return StateGame.win;

  return StateGame.running;
}

String oneLostMetadata() {
  return "";
}

// puntos por nivel
List<int> levelsMinPoints = [50, 80, 100];
// tipo de juego que termina cuando el player consigue una determinada cantidad de puntos
StateGame byPoints(List<FoodPreSprite> levelN, int points, int eatenFood,
    int lostFood, int currentLevel /*, bool isEaten*/) {
  if (points >= levelsMinPoints[currentLevel - 1]) return StateGame.win;
  if (levelN.length <= (eatenFood + lostFood)) return StateGame.lose;

  return StateGame.running;
}

String byPointsMetadata(int currentLevel) {
  return levelsMinPoints[currentLevel - 1].toString();
}

// tipo de dulces que no consumir
List<TypeFood> levelsOnlyTypeFood = [
  TypeFood.candy,
  TypeFood.cake,
  TypeFood.cake
];
// tipo de juego en el que solo se puede consumir un timpo de alimento
StateGame onlyTypeFood(List<FoodPreSprite> levelN, int index, int currentLevel,
    int eatenFood, int lostFood, bool isEaten) {
  if (levelN[(lostFood + eatenFood) - 1].food.typeFood !=
          levelsOnlyTypeFood[currentLevel - 1] &&
      isEaten) return StateGame.lose;

  if (levelN.length <= (eatenFood + lostFood)) return StateGame.win;

  return StateGame.running;
}

String onlyTypeFoodMetadata(int currentLevel) {
  return levelsOnlyTypeFood[currentLevel - 1].toString();
}

// tipo de dulces que no puede consumir
List<TypeFood> levelsNotEatenThisFood = [
  TypeFood.candy,
  TypeFood.cake,
  TypeFood.cake
];
// tipo de juego en el que solo se puede consumir un timpo de alimento
StateGame notEatenThisFood(List<FoodPreSprite> levelN, int index,
    int currentLevel, int eatenFood, int lostFood, bool isEaten) {
  if (levelN[(lostFood + eatenFood) - 1].food.typeFood ==
          levelsOnlyTypeFood[currentLevel - 1] &&
      isEaten) return StateGame.lose;

  if (levelN.length <= (lostFood + eatenFood)) return StateGame.win;
  return StateGame.running;
}

String notEatenThisFoodMetadata(int currentLevel) {
  return levelsOnlyTypeFood[1].toString();
}
