import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';

class SettingsButton extends StatelessWidget {
  final String title;
  final IconData trailingIcon;
  final VoidCallback onTap;
  const SettingsButton(
      {super.key, required this.title, required this.trailingIcon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor, width: 1.5)),
        child: ListTile(
          title: Text(
            title,
            style: getFontStyle(context).copyWith(
              fontSize: 20,
            ),
          ),
          trailing: Icon(trailingIcon),
        ),
      ),
    );
  }
}
