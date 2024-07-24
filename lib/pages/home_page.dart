import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/SearchPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;

  final User firebaseUser;
  HomePage({super.key, required this.userModel, required this.firebaseUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Home Page",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)
          {
return SearchPage(userModel: widget.userModel, firebaseUser: widget.firebaseUser);
          
          }));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
