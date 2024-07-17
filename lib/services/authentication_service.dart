import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/models/sign_in_result.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  bool isSignedIn() {
    return _auth.currentUser != null;
  }

  Future<SignInResult?> signInWithGoogle() async {
    try {
      googleSignInAccount = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      final bool isNewUser = authResult.additionalUserInfo!.isNewUser;

      if (isNewUser) {
        print("The user has just been created.");
      } else {
        print("The user already existed.");
      }
      return SignInResult(user: user, isNewUser: isNewUser);
    } catch (error) {
      log(error.toString());
      return null;
    }
  }

  void signOutGoogle() async {
    try {
      await _auth.signOut();
      await googleSignIn.disconnect();
      //_auth.currentUser == null ? print("succsss SOUT") : print("NOT SOUT");
    } catch (error) {
      print("Error during Google sign-in: $error");
      return null;
    }
  }

  Future<void> signInWithPhone(
      BuildContext context, String phoneNumber) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    print(phoneNumber);
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            print('============ Verification Completed ============');
            loadingProvider.hide();
            // await _auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            print('=========1=========');
            print("${error.message} OOOOOO ${error.code}");
            showTopSnackBar(
              dismissType: DismissType.onSwipe,
              dismissDirection: [
                DismissDirection.up,
                DismissDirection.horizontal
              ],
              Overlay.of(context),
              displayDuration: const Duration(milliseconds: 3000),
              reverseAnimationDuration: const Duration(milliseconds: 500),
              animationDuration: const Duration(milliseconds: 500),
              CustomSnackBar.error(
                message: error.message != null
                    ? error.message!
                    : 'Somthing went wrong',
              ),
            );
            loadingProvider.hide();
            throw Exception(error.message);
            
          },
          codeSent: (verificationId, forceResendingToken) {
            print('COD SSNNNTTT');

            loadingProvider.hide();
            context.goNamed(
              RouteNames.otp,
              extra: {'verificationId': verificationId},
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (error) {
      print('========2==========');
      print("${error.message} OOOOOO ${error.code}");
      loadingProvider.hide();
    }
  }

  Future<void> submitOTP(
      {required BuildContext context,
      required String otp,
      required String verificationId}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          smsCode: otp, verificationId: verificationId);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        context.goNamed(RouteNames.main);
      } else {}
    } on FirebaseAuthException catch (e) {
      print('========3==========');
      print(e.message.toString());
      //_isLoading = false;
    }
  }
}
