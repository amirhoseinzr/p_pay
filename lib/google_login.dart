import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:p_pay/utils/okto.dart';

import 'home_page.dart';

class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({super.key});

  Future<void> _handleGoogleLogin(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        // Pass user data to Okto if necessary
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    } catch (error) {
      print("Google Login failed: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: ElevatedButton(
          onPressed: () => _handleGoogleLogin(context),
          child: const Text("Login with Google"),
        ),
      ),
    );
  }
}
