import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/route_names.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help & Support",
          style: getFontStyle(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "How can we help you ?",
              style: getFontStyle(context).copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            PrimaryButton(
              text: "Fill a message",
              onPressed: () {
                context.pushNamed(RouteNames.helpForm);
              },
            ),
            SizedBox(
              height: 25,
            ),
            PrimaryButton(
              text: "Cantact an agent",
              onPressed: () {
                
              },
            ),
          ],
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
