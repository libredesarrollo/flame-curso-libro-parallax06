import 'package:flutter/material.dart';
import 'package:parallax06/main.dart';

class StatisticsOverlay extends StatefulWidget {
  final MyGame game;

  StatisticsOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<StatisticsOverlay> createState() => _StatisticsOverlayState();
}

class _StatisticsOverlayState extends State<StatisticsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/food.png',
                  width: 50,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.game.points.toString(),
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.amber,
                      shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.game.paused = !widget.game.paused;
                    });
                  },
                  child: Icon(
                    widget.game.paused ? Icons.play_arrow : Icons.pause,
                    size: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.game.loadLevel();
                  },
                  child: const Icon(
                    Icons.replay,
                    size: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.game.overlays.add('LevelSelection');
                  },
                  child: const Icon(
                    Icons.grid_on,
                    size: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.game.overlays.add('TypeGame');
                  },
                  child: const Icon(
                    Icons.gamepad,
                    size: 40,
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "E",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.amber,
                      shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.game.eatenFood.toString(),
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.amber,
                      shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "L",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.amber,
                      shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.game.lostFood.toString(),
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.amber,
                      shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
                )
              ],
            ),
            const Expanded(
                child: SizedBox(
              height: 50,
            )),
            Text(widget.game.typeGameDetail().toString()),
            Text("Level: ${widget.game.currentLevel}"),
          ]),
    );
  }
}
