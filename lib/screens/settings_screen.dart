import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:taxi_app/widgets/settings_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: getFontStyle(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            SettingsButton(
              onTap: () => context.pushNamed(RouteNames.),
              title: "Change Language",
              trailingIcon: Icons.keyboard_arrow_right,
            ),
            SettingsButton(
              title: "Terms & Condition)",
              trailingIcon: Icons.keyboard_arrow_right,
            ),
            SettingsButton(
              title: "Privacy & Policy",
              trailingIcon: Icons.keyboard_arrow_right,
            ),
            SettingsButton(
              title: "About us",
              trailingIcon: Icons.keyboard_arrow_right,
            ),
          ],
        ),
      ),
    );
  }
}
