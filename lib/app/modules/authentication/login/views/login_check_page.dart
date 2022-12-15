import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone/app/modules/authentication/auth_page.dart';
import 'package:instagram_clone/app/modules/authentication/login/views/login.dart';
import 'package:instagram_clone/app/modules/homepage/home_page.dart';
import 'package:instagram_clone/app/modules/main_navigation_page.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Sonething went wrong'),
              );
            } else if (snapshot.hasData) {
              return NavigationPage();
            } else {
              return AuthPage();
            }
          }),
    );
  }
}
