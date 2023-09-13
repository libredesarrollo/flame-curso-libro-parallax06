import 'package:flutter/material.dart';
import 'package:parallax06/main.dart';

class LevelSelectionOverlay extends StatefulWidget {
  MyGame game;
  LevelSelectionOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<LevelSelectionOverlay> createState() => _LevelSelectionOverlayState();
}

class _LevelSelectionOverlayState extends State<LevelSelectionOverlay> {
  late double screenWidth, screenHeight;

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
        padding: const EdgeInsets.all(150),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const Text(
              "Level Selection",
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: screenWidth > 900 ? 6 : 3,
                children: List.generate(6, (index) {
                  return _getLevel(index + 1);
                }),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _getLevel(int level) {
    return GestureDetector(
      onTap: () {
        widget.game.loadLevel(currentLevel: level);
        widget.game.overlays.remove('LevelSelection');
      },
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 4)),
        child: Text(
          level.toString(),
          style: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.w900, color: Colors.black),
        ),
      ),
    );
  }
}
