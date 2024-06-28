import 'package:firebase_auth/firebase_auth.dart';

class SignInResult {
  final User? user;
  final bool isNewUser;

  SignInResult({required this.user, required this.isNewUser});
}
