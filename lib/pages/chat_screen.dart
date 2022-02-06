import 'package:chat_app/core/services/auth/auth_mock_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Chat Page'),
            TextButton(
              onPressed: () {
                AuthMockService().logout();
              },
              child: Text('Sair'),
            )
          ],
        ),
      ),
    );
  }
}
