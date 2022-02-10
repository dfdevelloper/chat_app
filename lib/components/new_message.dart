import 'package:chat_app/core/services/auth/auth_service.dart';
import 'package:chat_app/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  final _msgController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await ChatService().save(_enteredMessage, user);
      _msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            onChanged: (msg) {
              setState(() {
                _enteredMessage = msg;
              });
            },
            onSubmitted: (_) {
              if (_enteredMessage.trim().isNotEmpty) _sendMessage();
            },
            controller: _msgController,
            decoration: InputDecoration(
              labelText: 'Enviar mensagem...',
            ),
          ),
        ),
        IconButton(
          onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          icon: Icon(Icons.send),
        )
      ],
    );
  }
}
