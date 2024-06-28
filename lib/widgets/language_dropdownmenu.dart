import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/providers/language_provider.dart';
// import 'package:taxi_app/enums/language_enum.dart';
import 'package:taxi_app/models/language.dart';
import 'package:taxi_app/utils/utils.dart';

class LanguageDropDownMenu extends StatefulWidget {
  const LanguageDropDownMenu({super.key});

  @override
  State<LanguageDropDownMenu> createState() => _LanguageDropDownMenuState();
}

class _LanguageDropDownMenuState extends State<LanguageDropDownMenu> {
    Image? img;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    // final langs = AppLanguage.values.map((e) => e.name).toList();
    // String dropdownValue = langs.first;
    return DropdownMenu(
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
              style: BorderStyle.solid, color: primaryColor, width: 2),
        ),
      ),
      hintText: 'Languages',
      textStyle: kFontStyle,
      width: getScreenWidth(context) * 0.8,
      onSelected: (value) {
        setState(() {
          if (value != null) {
            languageProvider.setSelectedLanguage(value);
            MyApp.setLocale(context, Locale(value));
            img = Language.getFlagByCode(value);
            log((img == null).toString());
          }
        });
      },
      dropdownMenuEntries: Language.languageList().map((value) {
        return DropdownMenuEntry<String>(
            labelWidget: Text(
              value.name,
              style: value.languageCode == 'ar'
                  ? GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600)
                  : kFontStyle.copyWith(fontSize: 18, letterSpacing: 1),
            ),
            value: value.languageCode,
            label: value.name,
            leadingIcon: value.flag);
      }).toList(),
      leadingIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: img ?? Icon(Icons.language),
      ),
    );
  }
}
