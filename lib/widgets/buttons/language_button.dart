import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/models/language.dart';
import 'package:taxi_app/providers/language_provider.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageButton extends StatelessWidget {
  final VoidCallback onTap;
  final Language lang;
  const LanguageButton({super.key, required this.lang, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    String langCode = languageProvider.selectedLanguage;
    double width = 1;
    Color borderColor = Colors.grey;
    bool isSelected = false;
    Color fillColor = Colors.white.withOpacity(0.75);
    if (langCode == lang.languageCode) {
      width = 2;
      borderColor = primaryColor;
      isSelected = true;
      fillColor = primaryColor.withOpacity(0.4);
    }

    String languageName = '';
    switch (lang.languageCode) {
      case 'en':
        languageName = AppLocalizations.of(context)!.english;
        break;
      case 'fr':
        languageName = AppLocalizations.of(context)!.french;
        break;
      case 'es':
        languageName = AppLocalizations.of(context)!.spanish;
        break;
      case 'ar':
        languageName = AppLocalizations.of(context)!.arabic;
        break;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: width, color: borderColor),
        ),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(5),
            child: lang.flag,
          ),
          title: Text(
            languageName,
            style: getFontStyle(context).copyWith(fontSize: 18),
          ),
          trailing: Visibility(
            visible: isSelected,
            child: Image.asset("assets/checked.png", width: 25),
          ),
        ),
      ),
    );
  }
}
