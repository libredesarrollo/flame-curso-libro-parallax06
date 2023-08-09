import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';
import 'package:parallax06/hud/joystick.dart';
import 'package:parallax06/hud/rotate_button.dart';

class HudComponent extends PositionComponent {
  late Joystick joystick;
  late RotateButton rotateButton;

  @override
  void onLoad() {
    final joystickKnobPaint = BasicPalette.red.withAlpha(200).paint();
    final joystickBackgroundPaint = BasicPalette.black.withAlpha(100).paint();
    final buttonBackgroundPaint = BasicPalette.blue.withAlpha(200).paint();
    final buttonDownBackgroundPaint = BasicPalette.blue.withAlpha(100).paint();

    joystick = Joystick(
        knob: CircleComponent(radius: 30.0, paint: joystickKnobPaint),
        background:
            CircleComponent(radius: 100, paint: joystickBackgroundPaint),
        margin: const EdgeInsets.only(left: 40, top: 100));
    rotateButton = RotateButton(
        button: CircleComponent(radius: 25, paint: buttonBackgroundPaint),
        buttonDown:
            CircleComponent(radius: 25, paint: buttonDownBackgroundPaint),
        margin: const EdgeInsets.only(right: 20, bottom: 20),
        onPressed: () => {});

    add(joystick);
    add(rotateButton);
  }
}
