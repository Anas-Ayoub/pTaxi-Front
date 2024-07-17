import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/services/authentication_service.dart';
// import 'package:taxi_app/models/user.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:taxi_app/widgets/primary_textfield.dart';
import 'package:taxi_app/widgets/top_snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PassengerAdditionalInfo extends StatefulWidget {
  const PassengerAdditionalInfo({super.key});

  @override
  State<PassengerAdditionalInfo> createState() =>
      _PassengerAdditionalInfoState();
}

final _formKey = GlobalKey<FormState>();

class _PassengerAdditionalInfoState extends State<PassengerAdditionalInfo> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  final User? user = FirebaseAuth.instance.currentUser;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    bool _hasEmail = false;
    if (user == null) {
      AuthService().signInWithGoogle();
    } else {
      if (user!.email != null) {
        _hasEmail = true;
        _emailController.text = user!.email!;
      }

    }

    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.personnelInformation,
            style: getFontStyle(context),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.pleaseEnterYourPersonnelInformation,
                    style: getFontStyle(context).copyWith(
                        color: Colors.black.withOpacity(1), fontSize: 18),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryTextfield(
                          controller: _firstNameController,
                          hintText: AppLocalizations.of(context)!.firstName,
                          validator: (txt) {
                            if (txt!.length < 3) {
                              return AppLocalizations.of(context)!.nameIsTooShort;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: PrimaryTextfield(
                        controller: _lastNameController,
                        hintText: AppLocalizations.of(context)!.lastName,
                        validator: (txt) {
                          if (txt!.length < 3) {
                            return AppLocalizations.of(context)!.nameIsTooShort;
                          } else {
                            return null;
                          }
                        },
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  PrimaryTextfield(
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    hintText: AppLocalizations.of(context)!.phoneNumber,
                    validator: (txt) {
                      if (txt!.length < 9) {
                        return AppLocalizations.of(context)!.mustContain9Digits;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  PrimaryTextfield(
                    isEnabled: !_hasEmail,
                    controller: _emailController,
                    hintText: AppLocalizations.of(context)!.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterAnEmail;
                      }
                      if (!RegExp(emailPattern).hasMatch(value)) {
                        return AppLocalizations.of(context)!.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  DropdownMenu<String>(
                    width: getScreenWidth(context) * 0.9,
                    inputDecorationTheme: InputDecorationTheme(
                      activeIndicatorBorder: BorderSide.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: primaryColor,
                        ),
                      ),
                      filled: true,
                      fillColor: primaryColor.withOpacity(0.3),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.gender,
                      style: getFontStyle(context)
                          .copyWith(color: Colors.black.withOpacity(0.75)),
                    ),
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    dropdownMenuEntries: [
                      DropdownMenuEntry<String>(
                        value: "male",
                        label: AppLocalizations.of(context)!.male,
                        // leadingIcon: Icon(icon.icon),
                      ),
                      DropdownMenuEntry<String>(
                        value: "female",
                        label: AppLocalizations.of(context)!.female,
                        // leadingIcon: Icon(icon.icon),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  PrimaryButton(
                    text: AppLocalizations.of(context)!.send,
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedGender != null) {
                        log(_firstNameController.text);
                        log(_lastNameController.text);
                        log(_emailController.text);
                        log(_phoneController.text);
                        log(_selectedGender.toString());

                        context.pushNamed(RouteNames.cityPick);
                      } else if (_formKey.currentState!.validate() &&
                          _selectedGender == null) {
                        mySnackBar(
                            context: context,
                            message: AppLocalizations.of(context)!.pleaseSelectAGender,
                            snackBarType: SnackBarType.info);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
