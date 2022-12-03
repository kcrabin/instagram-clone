import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone/app/modules/authentication/login/views/login.dart';
import 'package:instagram_clone/app/modules/authentication/register/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? Login_Page(onClickedSignup: toogle)
      : Signup_Page(onClickedLogin: toogle);

  void toogle() => setState(() => isLogin = !isLogin);
}
