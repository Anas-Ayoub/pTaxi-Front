import 'package:flutter/material.dart';

class Language {
  final int id;
  final Image flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static Image getFlagByCode(String langCode) {
    return languageList().firstWhere(
      (element) {
        return element.languageCode == langCode;
      },
    ).flag;
  }

  static List<Language> languageList() {
    return <Language>[
      Language(
          1,
          Image.asset(
            "assets/frFlag.png",
            width: 30,
          ),
          "Français",
          "fr"),
      Language(
          2,
          Image.asset(
            "assets/enFlag.png",
            width: 30,
          ),
          "Anglais",
          "en"),
      Language(
          3,
          Image.asset(
            "assets/arFlag.png",
            width: 30,
          ),
          "العربية",
          "ar"),
      Language(
          4,
          Image.asset(
            "assets/esFlag.png",
            width: 30,
          ),
          "Spanish",
          "es"),
    ];
  }
}
