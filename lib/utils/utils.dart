import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:taxi_app/screens/main_screen.dart';
import 'package:taxi_app/widgets/BottomSheets/driverComing_sheetContent.dart';
import 'package:vibration/vibration.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/language_provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/widgets/BottomSheets/TripOverview_SheetContent.dart';
import 'package:taxi_app/widgets/BottomSheets/findingDriver_sheetContent.dart';
import 'package:taxi_app/widgets/BottomSheets/pickLocation_sheetContent.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';

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

void showPickingLocationSheet(BuildContext context) {
  showBottomSheet(
    enableDrag: false,
    context: context,
    elevation: 4,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color with opacity
            spreadRadius: 7, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // Offset in x and y direction
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: const PickLocationSheetContent(),
    ),
  );
}

void showFindingTaxiSheet(BuildContext context) {
  context.read<MapProvider>().setIsFindingTaxi(true);

  showBottomSheet(
    enableDrag: false,
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color with opacity
            spreadRadius: 7, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // Offset in x and y direction
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: const FindingDriverSheetContent(),
    ),
  );
}

void showDriverComingSheet(BuildContext context)
{
  showBottomSheet(
    enableDrag: false,
    context: context,
    elevation: 4,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color with opacity
            spreadRadius: 7, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // Offset in x and y direction
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SizedBox(width: double.infinity, child: const DrivingComingSheetContent()),
    ),
  );
}
void showTripOverviewSheet(BuildContext context) {
  showBottomSheet(
    elevation: 3,
    enableDrag: false,
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color with opacity
            spreadRadius: 7, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // Offset in x and y direction
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: double.infinity,
          child: TripOverviewSheetcontent(),
        ),
      ),
    ),
  );
}

void showConfirmationDialog(
    BuildContext context, String message, VoidCallback yesButtonCallBack) {
  Widget yesButton = PrimaryButton(
    text: "Yes",
    onPressed: yesButtonCallBack,
    width: getScreenWidth(context) * 0.30,
    color: errorColor,
  );

  Widget noButton = PrimaryButton(
    text: "No",
    onPressed: () {
      context.pop();
    },
    width: getScreenWidth(context) * 0.30,
  );

  AlertDialog alert = AlertDialog(
    actionsOverflowButtonSpacing: 20,
    icon: Lottie.asset(
      "assets/lottie/info.json",
      height: 100,
      // width: 10,
    ),
    backgroundColor: Color.fromARGB(255, 213, 236, 255),
    content: Text(
      message,
      style: getFontStyle(context)
          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    actions: [yesButton, noButton],
    actionsAlignment: MainAxisAlignment.center,
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showSuccessDialog(BuildContext context, String message) {
  Widget okButton = PrimaryButton(
    text: "Ok",
    onPressed: () {
      context.pop();
    },
    color: primaryColor,
  );

  AlertDialog alert = AlertDialog(
    icon: Lottie.asset(
      "assets/lottie/rideCompleted2.json",
      height: 130,
      repeat: false,
      // width: 10,
    ),
    backgroundColor: Color.fromARGB(255, 220, 252, 218),
    content: Text(
      message,
      style: getFontStyle(context)
          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void rideRequestNotify() async {
  bool? hasVibrator = await Vibration.hasVibrator();
  if (hasVibrator?? false) {
    Vibration.vibrate(duration: 100);
  }
  cardSoundPlayer.play(cardSoundPlayer.source??AssetSource('sounds/pop3.mp3'));
}
