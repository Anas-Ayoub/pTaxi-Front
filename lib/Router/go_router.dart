import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/Router/router_transition.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taxi_app/screens/about_us.dart';
import 'package:taxi_app/screens/authentication_screen.dart';
import 'package:taxi_app/screens/help_form_screen.dart';
import 'package:taxi_app/screens/help_screen.dart';
import 'package:taxi_app/screens/history_screen.dart';
import 'package:taxi_app/screens/intro_language_screen.dart';
import 'package:taxi_app/screens/languages_screen.dart';
import 'package:taxi_app/screens/main_screen.dart';
import 'package:taxi_app/screens/otp_screen.dart';
import 'package:taxi_app/screens/passenger_additional_information.dart';
import 'package:taxi_app/screens/privacy_policy.dart';
import 'package:taxi_app/screens/profile_screen.dart';
import 'package:taxi_app/screens/settings_screen.dart';
import 'package:taxi_app/screens/splash_screen.dart';
import 'package:taxi_app/screens/terms_condition.dart';

final GoRouter _router = GoRouter(
  redirect: (BuildContext context, GoRouterState state) async {
    final isFL = Provider.of<AppProvider>(context, listen: false).isFirstLunch;
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;

    print('ROUTER ==> In Redirect');
    print('ROUTER ==> Is FirstLunch = $isFL');
    print("ROUTER ==> Is LoggedIn = $loggedIn");
    print("ROUTER ==> Path = ${state.path}");
    print("ROUTER ==> Name = ${state.name}");
    print("ROUTER ==> FullPath = ${state.fullPath}");
    print("ROUTER ==> MatchedLocation = ${state.matchedLocation}");
    print("ROUTER ==> Uri = ${state.uri}");

    if (RouteNames.noLoginScreens.contains(state.fullPath)) {
      return null;
    }
    if (state.fullPath == RouteNames.helpScreen) {
      return null;
    }
    if (isFL) {
      return RouteNames.splash;
    }
    if (!loggedIn) {
      return RouteNames.authetication;
    }
    return null;
  },
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: RouteNames.splash,
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen(); //OtpScreen(verificationId: '',); //MySlashScreen();
      },
    ),
    GoRoute(
      name: RouteNames.main,
      path: RouteNames.main,
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      name: RouteNames.profile,
      path: RouteNames.profile,
      pageBuilder: (context, state) {
        return buildCustomTransitionPage(ProfileScreen(), state);
      },
      // builder: (BuildContext context, GoRouterState state) {
      //   return RideRequestsPage();
      // },
    ),
    GoRoute(
      path: RouteNames.introLanguage,
      name: RouteNames.introLanguage,
      builder: (BuildContext context, GoRouterState state) {
        return const IntroLanguage();
      },
    ),
    GoRoute(
      path: RouteNames.authetication,
      name: RouteNames.authetication,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen();
      },
    ),
    GoRoute(
      path: RouteNames.passengerAdditionalInfo,
      name: RouteNames.passengerAdditionalInfo,
      builder: (BuildContext context, GoRouterState state) {
        return const PassengerAdditionalInfo();
      },
    ),
    GoRoute(
      path: "${RouteNames.otp}/:verificationId",
      name: RouteNames.otp,
      builder: (BuildContext context, GoRouterState state) {
        final verificationId = state.pathParameters['verificationId'];
        // Handle potential null verificationId
        return OtpScreen(verificationId: verificationId!);
      },
    ),
    GoRoute(
      path: RouteNames.helpScreen,
      name: RouteNames.helpScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpScreen();
      },
    ),
    GoRoute(
      path: RouteNames.helpForm,
      name: RouteNames.helpForm,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpFormSceen();
      },
    ),
    GoRoute(
      path: RouteNames.history,
      name: RouteNames.history,
      builder: (BuildContext context, GoRouterState state) {
        return const HistoryScreen();
      },
    ),
    GoRoute(
      path: RouteNames.settings,
      name: RouteNames.settings,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen();
      },
    ),
    GoRoute(
      path: RouteNames.termsCondition,
      name: RouteNames.termsCondition,
      builder: (BuildContext context, GoRouterState state) {
        return const TermsCondition();
      },
    ),
    GoRoute(
      path: RouteNames.privacyPolicy,
      name: RouteNames.privacyPolicy,
      builder: (BuildContext context, GoRouterState state) {
        return const PrivacyPolicy();
      },
    ),
    GoRoute(
      path: RouteNames.aboutUs,
      name: RouteNames.aboutUs,
      builder: (BuildContext context, GoRouterState state) {
        return const AboutUs();
      },
    ),
    GoRoute(
      path: RouteNames.changeLanguage,
      name: RouteNames.changeLanguage,
      builder: (BuildContext context, GoRouterState state) {
        return const LanguageScreen();
      },
    ),
  ],
);

GoRouter get router => _router;
