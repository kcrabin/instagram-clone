import 'package:flutter/material.dart';

import '../../../homepage/home_page.dart';
import '../../register/register.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final _formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;

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
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formfield,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                ),
                Image.asset(
                  'assets/images/logo1.png',
                  height: 60,
                  width: 130,
                ),
                const SizedBox(
                  height: 10,
                ),

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                    labelText: 'Phone number, username or email',
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

                    //  if (value!.isEmpty) {
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
                  controller: passwordController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
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
                // const PasswordField(label: 'Password'),
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
                    if (_formfield.currentState!.validate()) {
                      print('success');
                      emailcontroller.clear();
                      passwordController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homepage(),
                        ),
                      );
                    }
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Signup'))
          ],
        ),
      ),
    );
  }
}
