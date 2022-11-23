import 'package:flutter/material.dart';
import 'package:instagram_clone/views/home_screen/home_screen.dart';
import 'package:instagram_clone/views/login_screen/login_screen.dart';
import 'package:instagram_clone/widgets/input_field.dart';
import 'package:instagram_clone/widgets/password_field.dart';

class Signup_Page extends StatefulWidget {
  const Signup_Page({Key? key}) : super(key: key);

  @override
  State<Signup_Page> createState() => _Signup_PageState();
}

class _Signup_PageState extends State<Signup_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/logo1.png'),
              ),
              const Text(
                'Signup to see photos and videos',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
              const Text(
                'from your friends',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'OR',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.facebook),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Login with Facebook',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const InputField(label: 'Email'),
              const SizedBox(
                height: 10,
              ),
              const InputField(label: 'Full name'),
              const SizedBox(
                height: 10,
              ),
              const InputField(label: 'Username'),
              const SizedBox(
                height: 10,
              ),
              const PasswordField(label: 'Password'),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40)),
                child: const Text(
                  'Sign up',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'By signing up, you agree to our',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
              const Text(
                'Terms & conditions',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('I have account?'),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login_Page(),
                    ),
                  );
                },
                child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
