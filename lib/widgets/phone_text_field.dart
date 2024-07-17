import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const PhoneTextField({
    super.key,
    this.keyboardType = TextInputType.number,
    this.validator,
    required this.controller,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      style: getFontStyle(context).copyWith(fontSize: 19),
      keyboardType: widget.keyboardType,
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
              width: 1.5,
              color: primaryColor,
            ),
            borderRadius: BorderRadius.circular(10)),
        hintStyle:
            getFontStyle(context).copyWith(fontSize: 15),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: AppLocalizations.of(context)!.phoneNumber,
        prefixIcon: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
          constraints: const BoxConstraints(
            minWidth: 0.0,
            maxWidth: double.infinity,
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/morocco1.png",
                  width: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "+212",
                  style:getFontStyle(context).copyWith(fontSize: 16.5),
                ),
                const VerticalDivider(
                  thickness: 1.5,
                  color: Color.fromARGB(143, 0, 0, 0),
                  indent: 10,
                  endIndent: 10,
                ),
              ],
            ),
          ),
        ),
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
