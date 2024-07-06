import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/providers/language_provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/widgets/TripOverview_SheetContent.dart';
import 'package:taxi_app/widgets/pickLocation_sheetContent.dart';

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
    builder: (context) => PickLocationSheetContent(),
  );
}

void showTripOverviewSheet(BuildContext context) {
  showBottomSheet(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
    enableDrag: false,
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => const Padding(
      padding: EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: TripOverviewSheetcontent(),
      ),
    ),
  );
}

focusCameraOnBounds(
  BuildContext context,
  LatLng source,
  LatLng destination,
) async {
  LatLngBounds bounds = LatLngBounds(
    southwest: LatLng(
      source.latitude < destination.latitude
          ? source.latitude
          : destination.latitude,
      source.longitude < destination.longitude
          ? source.longitude
          : destination.longitude,
    ),
    northeast: LatLng(
      source.latitude > destination.latitude
          ? source.latitude
          : destination.latitude,
      source.longitude > destination.longitude
          ? source.longitude
          : destination.longitude,
    ),
  );
  CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(
    bounds,
    top: 100,
    bottom: getScreenHeight(context) * 0.5,
    right: 100,
    left: 100,
  );
  MapboxMapController controller =
      context.read<MapProvider>().mapboxMapController!;

  await controller.animateCamera(cameraUpdate).then(
    (value) {
      controller.getVisibleRegion().then(
        (value) {
          controller.animateCamera(
            CameraUpdate.newLatLngBounds(value),
          );
        },
      );
    },
  );
}
