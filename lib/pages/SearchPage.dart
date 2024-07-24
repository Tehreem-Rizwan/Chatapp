import 'dart:ui';

import 'package:chatapp/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;

  final User firebaseUser;
  const SearchPage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Search",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("email", isEqualTo: searchController.text)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot dataSnapshot =
                            snapshot.data as QuerySnapshot;
                        if (dataSnapshot.docs.length > 0) {
                          Map<String, dynamic> userMap = dataSnapshot.docs[0]
                              .data() as Map<String, dynamic>;
                          UserModel searchedUser = UserModel.fromMap(userMap);
                          return ListTile(
                            title: Text(searchedUser.fullname!),
                            subtitle: Text(searchedUser.email!),
                          );
                        } else {
                          return Text("No result found");
                        }
                      } else if (snapshot.hasError) {
                        return Text("An error occurred");
                      } else {
                        return Text("No result found");
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
