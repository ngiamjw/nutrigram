import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:nutrigram/auth/login_or_register.dart";
import "package:nutrigram/pages/home_page.dart";

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userEmail = snapshot.data?.email;
              return HomePage();
            } else {
              return LoginOrRegister();
            }
          }),
    );
  }
}
