import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/services/authentication_service.dart';
import 'package:taxi_app/widgets/phone_text_field%20copy.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_app/widgets/profile_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? resp;
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null){
      AuthService().signOutGoogle();
    }

    return SafeArea(
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ProfileFrame(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user!.displayName ?? 'N/A',
                    style: GoogleFonts.aBeeZee(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text('(4.7)')
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    hintText: AppLocalizations.of(context)!.firstName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    hintText: AppLocalizations.of(context)!.lastName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    hintText: AppLocalizations.of(context)!.phoneNumber,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    hintText: AppLocalizations.of(context)!.email,
                  ),
                  // TextButton(
                  //   onPressed: () async {
                  //     final user = FirebaseAuth.instance.currentUser;
                  //     if (user != null) {
                  //       final idTokenResult = await user.getIdTokenResult(true);
                  //       print(idTokenResult.token!);
                  //       sendTokenToBackend(idTokenResult.token!);
                  //     } else {
                  //       return;
                  //     }
                  //   },
                  //   child: Text("Fetch From Backend"),
                  // ),
                  resp != null ? Text(resp!) : Text(""),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendTokenToBackend(String idToken) async {
    print("IN FUNCTION");
    const backendUrl = 'http://192.168.100.149:3000/users';

    final response = await http.get(
      Uri.parse(backendUrl),
      headers: {},
    );
    print("Status COOODDDEEE ${response.statusCode}");
    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        print("IN SS");
        resp = response.body;
      });
    } else {
      setState(() {
        print("IN NN  ");

        resp = response.body;
      });
    }
  }
}
