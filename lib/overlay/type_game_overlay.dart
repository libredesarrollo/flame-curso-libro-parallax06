import 'package:flutter/material.dart';
import 'package:parallax06/main.dart';
import 'package:parallax06/utils/type_game.dart';

class TypeGameOverlay extends StatefulWidget {
  MyGame game;
  TypeGameOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<TypeGameOverlay> createState() => _TypeGameOverlayState();
}

class _TypeGameOverlayState extends State<TypeGameOverlay> {
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQueryData.fromView(View.of(context)).size.width;
    screenHeight = MediaQueryData.fromView(View.of(context)).size.height;

    return Container(
      color: Colors.black45,
      width: screenWidth,
      height: screenHeight,
      child: Center(
          child: Container(
        width: screenWidth - 150,
        height: screenHeight - 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const Text(
              "Type Game Selection",
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5,
                children: List.generate(4, (index) {
                  return _getTypeGame(index);
                }),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _getTypeGame(int index) {
    return GestureDetector(
      onTap: () {
        widget.game.loadLevel(typeGame: TypeGame.values[index]);
        widget.game.overlays.remove('TypeGame');
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Text(TypeGame.values[index].name,
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.black)),
      ),
    );
  }
}
