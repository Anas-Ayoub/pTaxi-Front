import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';

class PrimaryTextfield extends StatelessWidget {
    final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? isMultiLine;
  final String? hintText;
  final bool? isEnabled;
  const PrimaryTextfield({super.key, required this.controller, this.keyboardType, this.validator, this.hintText, this.isMultiLine, this.maxLines, this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType
      ,
      enabled: isEnabled,
      controller: controller,
      style: getFontStyle(context),
      validator: validator,
      maxLines: isMultiLine != null ? isMultiLine! ? null : 1 : 1,
      decoration: InputDecoration(
        
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.5,
              color: errorColor,
            ),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.5,
              color: errorColor,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 3,
              color: primaryColor,
            ),
            borderRadius: BorderRadius.circular(10)),
        hintStyle:
            getFontStyle(context).copyWith(color: Colors.black.withOpacity(0.5)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
              style: BorderStyle.solid,
              color: primaryColor,
            ),
          // borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: textFieldBackColor,
      ),
    );
  }
}