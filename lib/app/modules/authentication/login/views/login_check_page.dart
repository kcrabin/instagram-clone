import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone/app/modules/authentication/login/views/login.dart';
import 'package:instagram_clone/app/modules/homepage/home_page.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Homepage();
            } else {
              return Login_Page();
            }
          }),
    );
  }
}
