import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Joystick extends JoystickComponent {
  Joystick(
      {required PositionComponent knob,
      required PositionComponent background,
      required EdgeInsets margin})
      : super(knob: knob, background: background, margin: margin);
}
