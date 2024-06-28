import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/route_names.dart';
import 'package:taxi_app/screens/authentication_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> printAllSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();
    print(allKeys.length);

    for (final key in allKeys) {
      final value = prefs.get(key);
      print('Key: $key, Value: $value');
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).setFirstLunch(false);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final loggedIn = FirebaseAuth.instance.currentUser != null;
        if (loggedIn) {
          print('LOGGD IN ');
        } else {
          print('LOGGD OUT ');
        }

        final route = loggedIn ? RouteNames.main : RouteNames.authetication;
        context.go(route);
      },
    );
    //printAllSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backgroundImage), fit: BoxFit.cover),
        ),
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
