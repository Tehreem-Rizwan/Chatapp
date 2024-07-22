import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  Future<void> signup() async {
    if (passwordController.text != confirmpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password do not match"),
      ));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
          emailcontroller.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
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
                      "Lets create an account for you",
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
                    SizedBox(
                      height: 10,
                    ),
                    MyTextfield(
                        controller: confirmpasswordController,
                        hintText: " Confirm Password",
                        obscureText: true),
                    SizedBox(
                      height: 25,
                    ),
                    MyButton(onTap: signup, text: "Sign Up"),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already a member?"),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
