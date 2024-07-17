import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color? textColor;
  final double width;
  final double height;
  final bool? isBold;
  final Widget? icon;
  final double? elevation;
  final bool? enabled;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = primaryColor,
    this.width = double.infinity,
    this.height = 60,
    this.isBold = false,
    this.icon,
    this.textColor = Colors.white, this.elevation, this.enabled=true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          
          foregroundColor: textColor,
          backgroundColor: enabled == true ? color : Colors.grey,
          padding: EdgeInsets.zero,
          textStyle: getFontStyle(context).copyWith(fontWeight: isBold! ? FontWeight.bold : FontWeight.normal, fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.all(15),
                child: icon!,
              ),
            if (icon != null) const SizedBox(width: 5),
            Text(text),
          ],
        ),
      ),
    );
  }
}
