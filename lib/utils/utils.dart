import 'package:flutter/material.dart';

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

BoxDecoration getBackgroundDecoration() {
  String backgroundImage = "assets/StarBackground.png";
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(backgroundImage),
      fit: BoxFit.cover,
      alignment: Alignment.center,
    ),
  );
}
