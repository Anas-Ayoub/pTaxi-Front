import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:here_sdk/core.engine.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/Router/go_router.dart';
import 'package:taxi_app/providers/language_provider.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

late SharedPreferences prefs;
final FlutterLocalization localization = FlutterLocalization.instance;

String? langCode;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  langCode = prefs.getString('selectedLanguage');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.userChanges().listen((User? user) {
    print('in ===> userChanges().listen');
    router.refresh();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
        ChangeNotifierProvider(create: (context) => MapProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(langCode ?? "fr");

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _initializeHERESDK() async {
    // Needs to be called before accessing SDKOptions to load necessary libraries.
    SdkContext.init(IsolateOrigin.main);

    // Set your credentials for the HERE SDK.
    String accessKeyId = "9PRuNYmpSqWv3tc29Ux3LA";
    String accessKeySecret =
        "N-DF8dRVx1XnOzHuTREe80qkfcvaONm4uiJ-FM9eg57jFylZouGqDwYNY04A05Ytf23C0246QrFGsA7XBTJ7UQ";
    SDKOptions sdkOptions =
        SDKOptions.withAccessKeySecret(accessKeyId, accessKeySecret);
    

    try {
      await SDKNativeEngine.makeSharedInstance(sdkOptions);
    } on InstantiationException {
      throw Exception("Failed to initialize the HERE SDK.");
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeHERESDK();
  }

@override
  void dispose() {
    _disposeHERESDK();
    super.dispose();
  }
  void _disposeHERESDK() async {
  // Free HERE SDK resources before the application shuts down.
  await SDKNativeEngine.sharedInstance?.dispose();
  SdkContext.release();
}
  // getLang() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _locale = Locale(prefs.getString('selectedLanguage') ?? 'ar');
  // }

  // @override
  // void initState() {
  //   getLang();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final selectedLanguage =
    //     Provider.of<LanguageProvider>(context).getSelectedLanguage();
    // print("PROVDR $selectedLanguage");
    // _locale = Locale(getLang());

    return MaterialApp.router(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
      locale: _locale,
      title: 'app',
      theme: ThemeData(
        brightness: Brightness.light,
        // scaffoldBackgroundColor: const Color.fromARGB(255, 28, 31, 36),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}























// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   prefs = await SharedPreferences.getInstance();
//   prefs.clear();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   FirebaseAuth.instance.userChanges().listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });

//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (context) => LanguageProvider()),
//     ],
//     child: MyApp(
//       child: MaterialApp.router(
//         routerConfig: _router,
//         title: 'Taxi Demo',
//         theme: ThemeData(
//             brightness: Brightness.dark,
//             scaffoldBackgroundColor: Color.fromARGB(255, 28, 31, 36)),
//         debugShowCheckedModeBanner: false,
//       ),
//     ),
//   ));
// }

// class MyApp extends StatefulWidget {
//   final Widget? child;
//   MyApp({super.key, this.child});

//   static void restartApp(BuildContext context) {
//     context.findAncestorStateOfType<_MyAppState>()!.restartApp();
//   }

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Key key = UniqueKey();

//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return KeyedSubtree(key: key, child: widget.child!);
//   }
// }