import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class RotateButton extends HudButtonComponent {
  RotateButton(
      {required button, required buttonDown, EdgeInsets? margin, onPressed})
      : super(
            button: button,
            buttonDown: buttonDown,
            margin: margin,
            onPressed: onPressed);

// @override
//   void onTapUp(TapUpEvent event) {
//     // TODO: implement onTapUp
//     super.onTapUp(event);
//   }

// @override
//   void onTapDown(TapDownEvent event) {

//     super.onTapDown(event);
//   }

//   @override
//   void onTapCancel(TapCancelEvent event) {
//     // TODO: implement onTapCancel
//     super.onTapCancel(event);
//   }
}
