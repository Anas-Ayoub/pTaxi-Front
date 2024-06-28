import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';

class SettingsButton extends StatelessWidget {
  final String title;
  final IconData trailingIcon;
  const SettingsButton(
      {super.key, required this.title, required this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
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
    );
  }
}
