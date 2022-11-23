import 'package:flutter/material.dart';
import 'package:instagram_clone/views/home_screen/home_screen.dart';
import 'package:instagram_clone/views/signup_screen/signup_screen.dart';
import 'package:instagram_clone/widgets/input_field.dart';
import 'package:instagram_clone/widgets/password_field.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/logo1.png'),
                // Text(
                //   'Instagram',
                //   style: TextStyle(fontSize: 50),
                //   textAlign: TextAlign.center,
                // ),
              ),
              const SizedBox(
                height: 10,
              ),
              const InputField(label: 'Phone number, username or email'),
              const SizedBox(
                height: 10,
              ),
              const PasswordField(label: 'Password'),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    // style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
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
                  'Login',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
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
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.facebook),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Continue as Dave Johnson'),
                  )
                ],
              ),
              // Row(
              //   children: [
              //     const Text('Dont have account?'),
              //     TextButton(onPressed: () {}, child: const Text('Signup'))
              //   ],
              // )
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
            const Text('Don\'t have account?'),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup_Page(),
                    ),
                  );
                },
                child: const Text('Signup'))
          ],
        ),
      ),
    );
  }
}
