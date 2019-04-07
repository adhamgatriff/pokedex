import 'package:flutter/material.dart';

class CustomRect extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(-size.width, -20.0, size.width, size.height + 20);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomRectMirror extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTWH(
        size.width + 25, -10.0, -size.width - 25, size.height + 20);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
