import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/providers/language_provider.dart';

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

saveLanguage(BuildContext context) async {
  String code = context.read<LanguageProvider>().selectedLanguage;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('selectedLanguage', code);
}
