import 'package:flutter/material.dart';

class Settingscode {
  bool themeColor;
  bool inglis;

  Settingscode({this.themeColor = false, this.inglis = false});

  Color get cor => themeColor ? Colors.black : Colors.black;
}
