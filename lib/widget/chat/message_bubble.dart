import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final String message;
  final String username;
  final bool isMe;
  final String userImage;

  MessageBubble(this.key, this.message, this.username,this.userImage, this.isMe,);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: !isMe ? Colors.white10 : Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(14),
                    bottomRight: isMe ? Radius.circular(0) : Radius.circular(14),
                  )),
              width: 300,
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
              child: Column(
                crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: [
                  Text(username,
                      style: TextStyle(
                          color: !isMe? Colors.blue:Colors.black,
                          fontWeight: FontWeight.bold
                      )),
                  const SizedBox(height: 6),
                  Text(message,
                      style: TextStyle(
                        color: !isMe? Colors.white:Colors.white,
                      ),
                      textAlign: !isMe? TextAlign.end:TextAlign.start)
                ],
              ),
            )
          ],
        ),
         Positioned(
          top: -0,
            left:!isMe? 265:null,
            right: isMe?265:null,
            child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
            )),
      ],
    );
  }
}
