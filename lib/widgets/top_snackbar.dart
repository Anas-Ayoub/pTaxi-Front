import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum SnackBarType { success, failure, info }
int _displayDuration = 1500;
int _reverseAnimationDuration = 500;
int _animationDuration = 500;
void mySnackBar({
  required BuildContext context,
  required String message,
  required,
  SnackBarType snackBarType = SnackBarType.success,
}) {
  if (snackBarType == SnackBarType.success) {
    showTopSnackBar(
      dismissType: DismissType.onSwipe,
      dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
      Overlay.of(context),
      displayDuration: Duration(milliseconds: _displayDuration),
      reverseAnimationDuration: Duration(milliseconds: _reverseAnimationDuration),
      animationDuration: Duration(milliseconds: _animationDuration),
      SizedBox(
        // height: 65,
        child: CustomSnackBar.success(
          backgroundColor: const Color.fromARGB(255, 37, 145, 40),
          message: message,
        ),
      ),
    );
  } else if (snackBarType == SnackBarType.failure) {
    showTopSnackBar(
      dismissType: DismissType.onSwipe,
      dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
      Overlay.of(context),
      displayDuration: Duration(milliseconds: _displayDuration),
      reverseAnimationDuration: Duration(milliseconds: _reverseAnimationDuration),
      animationDuration: Duration(milliseconds: _animationDuration),
      CustomSnackBar.error(
        backgroundColor: errorColor,
        message: message,
      ),
    );
  } else {
    showTopSnackBar(
      
      dismissType: DismissType.onSwipe,
      dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
      Overlay.of(context),
      displayDuration: Duration(milliseconds: _displayDuration),
      reverseAnimationDuration: Duration(milliseconds: _reverseAnimationDuration),
      animationDuration: Duration(milliseconds: _animationDuration),
      CustomSnackBar.info(
        backgroundColor: const Color.fromARGB(255, 50, 92, 112),
        message: message,
      ),
    );
  }
}
