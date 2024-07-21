import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  void signIn() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  //logo
                  Icon(
                    Icons.message,
                    size: 80,
                    color: Colors.grey[800],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Welcome Back you have been missed!!",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  MyTextfield(
                      controller: emailcontroller,
                      hintText: "Email",
                      obscureText: false),
                  SizedBox(
                    height: 10,
                  ),
                  MyTextfield(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true),
                  const SizedBox(
                    height: 25,
                  ),
                  MyButton(onTap: signIn, text: "Sign In"),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a Member?"),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register now",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
