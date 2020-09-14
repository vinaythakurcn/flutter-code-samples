import 'package:education_app/components/app_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatMessage extends StatelessWidget {
  final String avatarUrl;
  final String message;
  final bool isMe;

  ChatMessage({
    @required this.avatarUrl,
    @required this.message,
    @required this.isMe,
  });

  static const myChatBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      topRight: Radius.circular(8.0),
      bottomRight: Radius.circular(8.0));

  static const otherChatBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(8.0),
      bottomLeft: Radius.circular(8.0),
      topRight: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0));

  List<Widget> getChatMsgCard(context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(top: 8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(avatarUrl),
          radius: 24.0,
        ),
      ),
      Container(
        margin: isMe ? EdgeInsets.only(right: 8.0) : EdgeInsets.only(left: 8.0),
        width: MediaQuery.of(context).size.width * 70 / 100,
        child: Material(
          borderRadius: isMe ? myChatBorderRadius : otherChatBorderRadius,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppText(
              text: message,
              color: isMe ? Colors.white : Color(kChatSenderMsgColor),
              size: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          color: isMe
              ? Theme.of(context).primaryColor
              : Color(kHighlightColorOpac),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: isMe
            ? getChatMsgCard(context).reversed.toList()
            : getChatMsgCard(context),
      ),
    );
  }
}
