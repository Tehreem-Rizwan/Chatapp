import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/models/UIHelper.dart';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/registerpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Logging In..");

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      // Close the loading dialog
      Navigator.pop(context);

      // Show Alert Dialog
      UIHelper.showAlertDialog(
          context, "An error occurred", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;

      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);

      // Go to HomePage
      print("Log In Successful!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage(
                userModel: userModel, firebaseUser: credential!.user!);
          },
        ),
      );
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
                  SizedBox(height: 50),
                  // logo
                  Icon(
                    Icons.message,
                    size: 80,
                    color: Colors.grey[800],
                  ),
                  SizedBox(height: 50),
                  const Text(
                    "Welcome Back you have been missed!!",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 50),
                  MyTextfield(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  MyTextfield(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),
                  CupertinoButton(
                    onPressed: () {
                      checkValues();
                    },
                    color: Colors.black,
                    child: Text(
                      "Log In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a Member?"),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }),
                          );
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
