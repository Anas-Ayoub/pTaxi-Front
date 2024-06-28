import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';

class DrawerIconButton extends StatelessWidget {
  const DrawerIconButton(
      {super.key, required this.text, required this.iconPath, required this.onPressed});
  final String text;
  final String iconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double _size = 22;

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Image.asset(
                iconPath,
                width: _size,
                height: _size,
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                text,
                style: getFontStyle(context).copyWith(fontSize: _size),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
