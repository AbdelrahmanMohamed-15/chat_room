import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (_controller.text.isNotEmpty)
      FirebaseFirestore.instance.collection('messages').add({
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'username': userData['username'],
        'userId': user.uid,
        'userImage': userData['image_url']
      });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black45),
            child: TextField(
              autocorrect: true,
              enableSuggestions: true,
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type your Message',
                hintStyle: TextStyle(color: Colors.deepOrange),
              ),
              onChanged: (val) {
                setState(() {
                  _enteredMessage = val;
                });
              },
            ),
          )),
          IconButton(
              onPressed: _sendMessage,
              icon: const Icon(
                Icons.send,
                color: Colors.deepOrange,
                size: 25,
              ))
        ],
      ),
    );
  }
}
