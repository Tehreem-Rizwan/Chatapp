import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instance of AuthService
    final authService = Provider.of<AuthService>(context, listen: false);

    void signOut() {
      authService.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.grey,
      body: _buildUserList(context), // Pass the context here
    );
  }

  // Build a list of users except for the current logged-in user.
  Widget _buildUserList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document, BuildContext context) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null) {
      return Container();
    }

    // Check if the necessary fields exist before accessing them
    String? email = data['email'] as String?;
    String? uid = data['uid'] as String?;

    if (email != null && uid != null && _auth.currentUser?.email != email) {
      return ListTile(
        title: Text(email),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiveruserEmail: email,
                receiveruserID: uid,
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
