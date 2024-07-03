import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/providers/language_provider.dart';
import 'package:taxi_app/screens/BottomContent.dart';

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

void showFindDriverSheet(BuildContext context) {
  showBottomSheet(
    enableDrag: false,
    context: context,
    builder: (context) => BottomSheetContent(),
  );
}

void showOtherSheet(BuildContext context) {
  log("In Other");
  showBottomSheet(
    enableDrag: false,
    context: context,
    builder: (context) => Padding(padding: EdgeInsets.all(12), child: Container(height: 100, color: Colors.indigo,),),
  );
}
