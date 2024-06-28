import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/widgets/phone_text_field%20copy.dart';
import 'package:http/http.dart' as http;

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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfilePicture(
                  name: user!.displayName ?? 'NO NAM',
                  radius: 40,
                  fontsize: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user.displayName ?? 'NO NAM',
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
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text('(4.7)')
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'First Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'Last Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'Phone Number',
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: 'Email',
                ),
                TextButton(
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      final idTokenResult = await user.getIdTokenResult(true);
                      print(idTokenResult.token!);
                      sendTokenToBackend(idTokenResult.token!);
                    } else {
                      return;
                    }
                  },
                  child: Text("Fetch From Backend"),
                ),
                resp != null ? Text(resp!) : Text(""),
              ],
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
