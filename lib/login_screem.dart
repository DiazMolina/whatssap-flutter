import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whatsapp/main.dart';

class LoginScreem extends StatelessWidget {
  final GoogleSignIn _googleSingIn = GoogleSignIn();
  final FirebaseAuth _aut = FirebaseAuth.instance;

  _login(BuildContext context) async {
    GoogleSignInAccount user = await _googleSingIn.signIn();
    GoogleSignInAuthentication auth = await user.authentication;
    FirebaseUser fUser = await _aut.signInWithGoogle(
        idToken: auth.idToken, accessToken: auth.accessToken);
    print("inicado ${fUser.displayName}");

    if (fUser != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MaterialApp(
                    home: MyHomePage(user: fUser),
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () => _login(context),
        ),
      ),
    );
  }
}
