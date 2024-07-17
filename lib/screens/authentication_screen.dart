import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/models/sign_in_result.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:taxi_app/services/authentication_service.dart';
import 'package:taxi_app/widgets/phone_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:taxi_app/widgets/top_snackbar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SnackBarType { success, failure, info }

final _formKey = GlobalKey<FormState>();

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _phoneController;
  late ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context: context);
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: MediaQuery.of(context).size.height/7,),
                    Text(AppLocalizations.of(context)!.authMessage,
                        textAlign: TextAlign.center,
                        style: getFontStyle(context).copyWith(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Text(
                      AppLocalizations.of(context)!.wellSendACodeToVerifyYourNumber,
                      textAlign: TextAlign.center,
                      style: getFontStyle(context).copyWith(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    PhoneTextField(
                      controller: _phoneController,
                      validator: (txt) {
                        if (txt!.length < 9) {
                          return AppLocalizations.of(context)!.mustContain9Digits;
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    PrimaryButton(
                      text: AppLocalizations.of(context)!.next,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final loadingProvider = Provider.of<LoadingProvider>(
                              context,
                              listen: false);

                          String phoneNumber =
                              "+212${_phoneController.text.trim()}";
                          print(phoneNumber);

                          loadingProvider.show(
                            context,
                            msg: AppLocalizations.of(context)!.signInWithPhoneNumber,
                          );

                          await AuthService()
                              .signInWithPhone(context, phoneNumber);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      AppLocalizations.of(context)!.orLoginWith,
                      textAlign: TextAlign.center,
                      style: getFontStyle(context),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: true,
                      child: PrimaryButton(
                        text: AppLocalizations.of(context)!.continueWithGoogle,
                        color: Color.fromARGB(255, 63, 63, 63),
                        icon: Image.asset(
                          "assets/google.png",
                        ),
                        isBold: true,
                        onPressed: () async {
                          final loadingProvider = Provider.of<LoadingProvider>(
                              context,
                              listen: false);
                          loadingProvider.show(
                            context,
                            msg: AppLocalizations.of(context)!.signingInWithGoogle,
                          );

                          SignInResult? res =
                              await AuthService().signInWithGoogle();
                          if (res != null) {
                            mySnackBar(
                                context: context,
                                message: AppLocalizations.of(context)!.successfullySignedIn);
                            loadingProvider.hide();
                            // await Future.delayed(
                            //   const Duration(milliseconds: 1200),
                            // );
                            if (res.isNewUser) {
                              context
                                  .goNamed(RouteNames.passengerAdditionalInfo);
                            } else {
                              //CHECK IF COMPLETED INFOS
                              context.goNamed(RouteNames.main);
                            }
                          } else {
                            // log()
                            showTopSnackBar(
                              dismissType: DismissType.onSwipe,
                              dismissDirection: [
                                DismissDirection.up,
                                DismissDirection.horizontal
                              ],
                              Overlay.of(context),
                              displayDuration:
                                  const Duration(milliseconds: 3000),
                              reverseAnimationDuration:
                                  const Duration(milliseconds: 500),
                              animationDuration:
                                  const Duration(milliseconds: 500),
                              CustomSnackBar.error(
                                message: AppLocalizations.of(context)!.authenticationFailed,
                              ),
                            );
                            loadingProvider.hide();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: getFontStyle(context).copyWith(fontSize: 12),
                        children: [
                          TextSpan(
                              text:
                                  AppLocalizations.of(context)!.termsMessage),
                          TextSpan(
                            text: AppLocalizations.of(context)!.termsOfUse,
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {},
                          ),
                           TextSpan(text: AppLocalizations.of(context)!.and),
                          TextSpan(
                            text: AppLocalizations.of(context)!.privacyPolicy,
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                // const backendUrl =
                                //     'http://192.168.100.149:3000/users';

                                // final response = await http.get(
                                //   Uri.parse(backendUrl),
                                //   headers: {},
                                // );
                                // print("Status COOODDDEEE ${response.statusCode}");
                                // log("SUCCSS 2");
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "ⓘ ",
                          style: getFontStyle(context).copyWith(
                            color: Color.fromARGB(255, 0, 135, 153),
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.help,
                          style: getFontStyle(context).copyWith(
                              fontSize: 17,
                              color: Color.fromARGB(255, 0, 135, 153),
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => context.pushNamed(RouteNames.helpScreen),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
