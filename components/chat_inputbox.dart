import 'package:flutter/material.dart';

class ChatInputBox extends StatelessWidget {
  final _controller = TextEditingController();

  final Function onSend;

  ChatInputBox({@required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.add),
            tooltip: 'Emojis',
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Start typing...',
              ),
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.near_me),
            tooltip: 'Send message',
            onPressed: () {
              final data = _controller.value.text;
              _controller.clear();

              onSend(data);
            },
          ),
        ],
      ),
    );
  }
}
