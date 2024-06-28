import 'package:flutter/material.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:taxi_app/widgets/primary_textfield.dart';

class HelpFormSceen extends StatefulWidget {
  const HelpFormSceen({super.key});

  @override
  State<HelpFormSceen> createState() => _HelpFormSceenState();
}

final _formKey = GlobalKey<FormState>();

class _HelpFormSceenState extends State<HelpFormSceen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _msgController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _msgController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Help & Support",
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
                    "How can we help you ?",
                    style: getFontStyle(context).copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryTextfield(
                          controller: _firstNameController,
                          hintText: "First Name",
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: PrimaryTextfield(
                        controller: _lastNameController,
                        hintText: "Last Name",
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  PrimaryTextfield(
                    controller: _phoneController,
                    hintText: "Phone Number",
                    validator: (txt) {
                      if (txt!.length < 9) {
                        return 'Must contain 9 digits';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  PrimaryTextfield(
                    controller: _msgController,
                    hintText: "What is the issue you are facing...",
                    isMultiLine: true,
                    validator: (txt) {
                      if (txt!.trim().length < 10) {
                        return 'Must contain at least 10 character';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  PrimaryButton(
                    text: "Send",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
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
