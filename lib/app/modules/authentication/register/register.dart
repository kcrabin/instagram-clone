import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app/modules/widgets/utils.dart';

import '../../../../main.dart';
import '../../homepage/home_page.dart';
import '../login/views/login.dart';

class Signup_Page extends StatefulWidget {
  final VoidCallback onClickedLogin;

  const Signup_Page({Key? key, required this.onClickedLogin}) : super(key: key);

  @override
  State<Signup_Page> createState() => _Signup_PageState();
}

class _Signup_PageState extends State<Signup_Page> {
  final _formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final fullnamecontroller = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;

  Future Signup() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    usernamecontroller.dispose();
    fullnamecontroller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formfield,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Image.asset(
                  'assets/images/logo1.png',
                  height: 60,
                  width: 130,
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  validator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);

                    if (value.isEmpty) {
                      return "Please Enter Email";
                    } else if (!emailValid) {
                      return "Enter valid Email";
                    }
                    // if (value!.isEmpty) {
                    //   return "Please Enter Email";
                    // } else if (!emailValid) {
                    //   return "Enter valid Email";
                    // }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: fullnamecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please Enter Full name";
                  //   }
                  // },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: usernamecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please Enter Username";
                  //   }
                  // },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(8),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    } else if (passwordController.text.length < 6) {
                      return "Password should not be less than 6 characters";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formfield.currentState!.validate()) {
                      print("success");
                      Signup();
                      emailcontroller.clear();
                      usernamecontroller.clear();
                      fullnamecontroller.clear();
                      passwordController.clear();
                    }
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
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'I have account?',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedLogin,
                    text: 'Log in',
                    style: const TextStyle(color: Colors.blue))
              ]),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Text('I have account?'),
        //     TextButton(
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => Login_Page(),
        //             ),
        //           );
        //         },
        //         child: const Text('Login'))
        //   ],
        // ),
      ),
    );
  }
}
