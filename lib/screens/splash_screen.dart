import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool?> checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();
    print(allKeys.length);

    for (final key in allKeys) {
      final value = prefs.get(key);
      print('Key: $key, Value: $value');
    }
    return prefs.getBool("isFirstLaunch") ?? true;
  }

  @override
  void initState() {
    log("In Splash");
    super.initState();
    bool? isFirstLaunch;
    checkFirstLaunch().then((value) => isFirstLaunch = value,);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final loggedIn = FirebaseAuth.instance.currentUser != null;
        if (loggedIn) {
          print('LOGGD IN ');
        } else {
          print('LOGGD OUT ');
        }
        if (loggedIn) {
          context.goNamed(RouteNames.main);
        } else if (isFirstLaunch == true) {
          context.goNamed(RouteNames.introLanguage);
        } else {
          context.goNamed(RouteNames.authetication);
        }
        // context.goNamed(RouteNames.introLanguage);
      },
    );
    //printAllSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: getBackgroundDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(85),
                child: SizedBox(
                  // height: 75,
                  // width: 75,
                  child: Image.asset('assets/petit_taxi-04.png'),
                ),
              ),
              // Text("Logo"),
            ],
          ),
        ),
      ),
    );
  }
}
