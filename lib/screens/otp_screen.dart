import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/pinput.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
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
                    AppLocalizations.of(context)!.verification,
                    textAlign: TextAlign.center,
                    style: getFontStyle(context).copyWith(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    AppLocalizations.of(context)!.enterTheCode6DigitsCodeSentToTheNumber,
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
                    AppLocalizations.of(context)!.didntReceiveCode,
                    textAlign: TextAlign.center,
                    style: getFontStyle(context).copyWith(),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.resend, style: getFontStyle(context).copyWith(color: primaryColor),),
                  ),
                  PrimaryButton(
                    text: AppLocalizations.of(context)!.verify,
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
