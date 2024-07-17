import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//COLORS
const Color primaryColor = Color.fromARGB(255, 0, 98, 51);
const Color errorColor = Color.fromARGB(255, 153, 0, 0);
Color textFieldBackColor = primaryColor.withOpacity(0.4);

//OTP PINPUT
Color pinputBackColor = primaryColor.withOpacity(0.3);
TextStyle pinputFont = GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 23, color: primaryColor);


//APP BACKGROUND IMAGE
// String backgroundImage = "assets/StarBackground.png";

//APP FONTS
TextStyle _kFontStyle = GoogleFonts.ubuntu(color: Colors.black);
TextStyle kArabicFontStyle = GoogleFonts.cairo(color: Colors.black);
TextStyle getFontStyle(BuildContext context) {
  Locale currentLocale = Localizations.localeOf(context);

  if (currentLocale.languageCode == 'ar') {
    return kArabicFontStyle;
  } else {
    return _kFontStyle;
  }
}