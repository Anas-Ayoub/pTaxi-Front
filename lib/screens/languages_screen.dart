import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/models/language.dart';
import 'package:taxi_app/providers/language_provider.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/language_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:taxi_app/widgets/top_snackbar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _currentLanguageCode = "en";
  @override
  void initState() {
    super.initState();
    _currentLanguageCode = context.read<LanguageProvider>().selectedLanguage;
  }
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.5),
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_rounded), onPressed: () {
            log("In POP");
            languageProvider.setSelectedLanguage(_currentLanguageCode);
            context.pop();
          },),
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.changeLanguage,
            style: getFontStyle(context),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: Language.languageList().map(
                    (lang) {
                      return LanguageButton(
                        lang: lang,
                        onTap: () {
                          setState(() {
                            languageProvider.setSelectedLanguage(lang.languageCode);
                            MyApp.setLocale(context, Locale(lang.languageCode));
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
              // Spacer(),
              PrimaryButton(text: "Save", onPressed: () {
                saveLanguage(context);
                mySnackBar(context: context, message: "Language Saved");
                context.pop();
              },)
            ],
          ),
        ),
      ),
    );
  }
}
