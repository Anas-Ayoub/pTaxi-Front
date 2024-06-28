import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum SnackBarType { success, failure, info }

void mySnackBar({
  required BuildContext context,
  required String message,
  required,
  SnackBarType snackBarType = SnackBarType.info,
}) {
  if (snackBarType == SnackBarType.success) {
    showTopSnackBar(
      dismissType: DismissType.onSwipe,
      dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
      Overlay.of(context),
      displayDuration: Duration(milliseconds: 3000),
      reverseAnimationDuration: Duration(milliseconds: 500),
      animationDuration: Duration(milliseconds: 500),
      const CustomSnackBar.info(
        backgroundColor: Color.fromARGB(255, 37, 145, 40),
        message: "Good job, your release is successful. Have a nice day",
      ),
    );
  } else if (snackBarType == SnackBarType.failure) {
    showTopSnackBar(
      dismissType: DismissType.onSwipe,
      dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
      Overlay.of(context),
      displayDuration: Duration(milliseconds: 3000),
      reverseAnimationDuration: Duration(milliseconds: 500),
      animationDuration: Duration(milliseconds: 500),
      const CustomSnackBar.error(
        backgroundColor: Color.fromARGB(255, 37, 145, 40),
        message: "Good job, your release is successful. Have a nice day",
      ),
    );
  } else {
    showTopSnackBar(
      dismissType: DismissType.onSwipe,
      dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
      Overlay.of(context),
      displayDuration: Duration(milliseconds: 3000),
      reverseAnimationDuration: Duration(milliseconds: 500),
      animationDuration: Duration(milliseconds: 500),
      const CustomSnackBar.info(
        backgroundColor: Color.fromARGB(255, 37, 145, 40),
        message: "Good job, your release is successful. Have a nice day",
      ),
    );
  }
  showTopSnackBar(
    dismissType: DismissType.onSwipe,
    dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
    Overlay.of(context),
    displayDuration: Duration(milliseconds: 3000),
    reverseAnimationDuration: Duration(milliseconds: 500),
    animationDuration: Duration(milliseconds: 500),
    const CustomSnackBar.success(
      backgroundColor: Color.fromARGB(255, 37, 145, 40),
      message: "Good job, your release is successful. Have a nice day",
    ),
  );
}
