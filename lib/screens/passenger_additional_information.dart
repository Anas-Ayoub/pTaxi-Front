import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class PassengerAdditionalInfo extends StatelessWidget {
  const PassengerAdditionalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(), // Adds the border
              ),
            ),
            TextButton(
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    try {
                      user.getIdToken(true).then((idToken) async {
                        String url = "http://localhost:3000/user";
                        final response = await http.post(
                          Uri.parse(url),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $idToken',
                          },
                          body: {
                            "firebaseAuthId": user.uid,
                            "email": "test@test,com",
                            "name": "ANAS",
                            "userType": "driver",
                          },
                        );

                        if (response.statusCode == 200) {
                          log("USER SAVED INTO DATABASE");
                          String url = "http://localhost:3000/driver";
                          await http.post(
                            Uri.parse(url),
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization': 'Bearer $idToken',
                            },
                            body: {
                              "vehicleId": "sfad",
                              "licenseNumber": "walla",
                              "rating": 5.3,
                              "status": "available",
                            },
                          );
                        } else {
                          log("USER DOESN'T SAVED INTO DATABASE");
                        }
                      });
                    } catch (e) {
                      log(e.toString());
                    }
                  }
                },
                child: const Text("Save"))
          ],
        ),
      )),
    );
  }
}
