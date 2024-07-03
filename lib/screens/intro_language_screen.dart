import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/language_provider.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/language_dropdownmenu.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroLanguage extends StatefulWidget {
  const IntroLanguage({super.key});

  @override
  State<IntroLanguage> createState() => _IntroLanguageState();
}

class _IntroLanguageState extends State<IntroLanguage> {
    Future<void> showSP() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();
    print(allKeys.length);

    for (final key in allKeys) {
      final value = prefs.get(key);
      print('Key: $key, Value: $value');
    }
  }
  Future<void> loadSP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstLaunch", false);
  }
  @override
  void initState() {
    log("In Intro Lang");
    super.initState();
    loadSP().then((value) => showSP(),);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text(languageProvider.selectedLanguage),
                  // TextButton(
                  //   child: Text("SP"),
                  //   onPressed: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => SharedPreferencesList(),
                  //     ));
                  //   },
                  // ),
                  Image.asset(
                    "assets/languages.gif",
                    scale: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.hello,
                    style: getFontStyle(context).copyWith(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const LanguageDropDownMenu(),
                  const SizedBox(
                    height: 40,
                  ),
                  PrimaryButton(
                    width: getScreenWidth(context) * 0.8,
                    text: AppLocalizations.of(context)!.next,
                    onPressed: () {
                      saveLanguage(context);
                      context.go(RouteNames.authetication);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
