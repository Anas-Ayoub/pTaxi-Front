import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.helpAndSupport,
            style: getFontStyle(context),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                AppLocalizations.of(context)!.howCanWeHelpYou,
                style: getFontStyle(context).copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 40,
              ),
              PrimaryButton(
                text: AppLocalizations.of(context)!.fillAMessage,
                onPressed: () {
                  context.pushNamed(RouteNames.helpForm);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              PrimaryButton(
                text: AppLocalizations.of(context)!.contactAnAgent,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchCaller(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
