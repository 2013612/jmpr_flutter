import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'local_widgets/google_sign_in_button.dart';
import 'user_info.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          return UserInfoPage(user: snapshot.data!);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("login"),
          ),
          body: Center(child: GoogleSignInButton()),
        );
      },
    );
  }
}
