import 'package:chat_room/widget/chat/messeges.dart';
import 'package:chat_room/widget/chat/newmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat Room',
          style: TextStyle(fontSize: 25,color: Colors.deepOrange),
        ),
        backgroundColor: Color(0xFF00061a),
        actions: [
          DropdownButton(
            icon: const Icon(
              Icons.more_vert,
              size: 30,
              color: Colors.deepOrange,
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app,color: Colors.deepOrange,),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout')
                  ],
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentify) {
              if (itemIdentify == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            underline: Container(
              height: 0,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: Messages()), const NewMessage()],
        ),
      ),
    );
  }
}
