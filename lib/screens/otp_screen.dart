import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/widgets/pinput.dart';
import 'package:taxi_app/widgets/primary_button.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/otp.gif", height: 200, width: 200,),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Verification",
                    textAlign: TextAlign.center,
                    style: getFontStyle(context).copyWith(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Enter the Code 6-digits Code Sent to the Number",
                    textAlign: TextAlign.center,
                    style: getFontStyle(context).copyWith(fontSize: 19),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "+212123456789",
                    textAlign: TextAlign.center,
                    style: getFontStyle(context).copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledRoundedPinPut(verificationId: widget.verificationId),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Didn't recieve code ?",
                    textAlign: TextAlign.center,
                    style: getFontStyle(context).copyWith(),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Resend", style: getFontStyle(context).copyWith(color: primaryColor),),
                  ),
                  PrimaryButton(
                    text: 'Verify',
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
