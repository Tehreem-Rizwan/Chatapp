import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/models/UIHelper.dart';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/completedProfile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  void checkValues() {
    String email = emailcontroller.text.trim();
    String password = passwordController.text.trim();
    String cPassword = confirmpasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else if (password != cPassword) {
      UIHelper.showAlertDialog(context, "Password Mismatch",
          "The passwords you entered do not match!");
    } else {
      signUp(email, password);
    }
  }

  void signUp(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Creating new account..");

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);

      UIHelper.showAlertDialog(
          context, "An error occured", ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser =
          UserModel(uid: uid, email: email, fullname: "", profilepic: "");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) {
        print("New User Created!");
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return CompleteProfile(
                userModel: newUser, firebaseUser: credential!.user!);
          }),
        );
      });
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
                      "Lets create an account for you!!",
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
                    CupertinoButton(
                      onPressed: () {
                        checkValues();
                      },
                      color: Colors.black,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
                        CupertinoButton(
                          color: Colors.grey[300],
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
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
