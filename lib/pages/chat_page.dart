import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiveruserEmail;
  final String receiveruserID;
  const ChatPage(
      {super.key,
      required this.receiveruserEmail,
      required this.receiveruserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(widget.receiveruserEmail),
    ));
  }
}
