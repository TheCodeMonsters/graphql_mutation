import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

/// GoogleSign #1

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

/// GoogleSign #2

googleLogin() async {
  print("Google Login");
  final _googleSignInAccount = GoogleSignIn();
  var result = await _googleSignInAccount.signIn();
  print("Result: $result");
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('LoginScreen'),
      ),
    );
  }
}
