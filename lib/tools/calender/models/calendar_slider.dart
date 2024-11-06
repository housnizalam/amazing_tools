

import 'dart:ui';

class CalenderSlider {
  static Offset beginn = const Offset(0, 0);
  static int duration = 800;
  static String animationsType = 'slide';
  static right() {
    beginn = const Offset(1, 0);
  }

  static left() {
    beginn = const Offset(-1, 0);
  }

  static up() {
    beginn = const Offset(0, -1);
  }

  static down() {
    beginn = const Offset(0, 1);
  }

  static scale() {
    animationsType = 'Scale';
    duration = 800;
    Future.delayed(const Duration(milliseconds: 800)).whenComplete(() {
      animationsType = 'Slide';
    });
  }
}