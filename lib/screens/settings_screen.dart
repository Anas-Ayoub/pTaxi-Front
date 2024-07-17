import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/settings_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.settings,
            style: getFontStyle(context),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              SettingsButton(
                onTap: () => context.pushNamed(RouteNames.changeLanguage),
                title: AppLocalizations.of(context)!.changeLanguage,
                trailingIcon: Icons.keyboard_arrow_right,
              ),
              SettingsButton(
                onTap: () => context.pushNamed(RouteNames.termsCondition),
                title: AppLocalizations.of(context)!.termsAndConditions,
                trailingIcon: Icons.keyboard_arrow_right,
              ),
              SettingsButton(
                onTap: () => context.pushNamed(RouteNames.privacyPolicy),
                title: AppLocalizations.of(context)!.privacyPolicy,
                trailingIcon: Icons.keyboard_arrow_right,
              ),
              SettingsButton(
                onTap: () => context.pushNamed(RouteNames.aboutUs),
                title: AppLocalizations.of(context)!.aboutUs,
                trailingIcon: Icons.keyboard_arrow_right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
