import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/constant/const.dart';

class MyTextField extends StatefulWidget {
  //final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  const MyTextField({
    super.key,
    this.hintText = "",
    this.validator,
    //required this.controller,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
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
      //controller: widget.controller,
      validator: widget.validator,
      style: GoogleFonts.aBeeZee(fontSize: 19),
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
            GoogleFonts.aBeeZee(fontSize: 15, fontWeight: FontWeight.normal),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: textFieldBackColor,
      ),
    );
  }
}
