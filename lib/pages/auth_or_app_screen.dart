import 'package:chat_app/core/models/chat_user.dart';
import 'package:chat_app/core/services/auth/auth_mock_service.dart';
import 'package:chat_app/pages/auth_screen.dart';
import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/loading_screen.dart';
import 'package:flutter/material.dart';

class AuthOrAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthMockService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return snapshot.hasData ? ChatPage() : AuthScreen();
          }
        },
      ),
    );
  }
}
