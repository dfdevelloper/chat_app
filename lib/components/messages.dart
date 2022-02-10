import 'package:chat_app/components/message_ballon.dart';
import 'package:chat_app/core/models/chat_message.dart';
import 'package:chat_app/core/services/auth/auth_service.dart';
import 'package:chat_app/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('Sem mensagens. Vamos conversar?'),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, idx) {
              return MessageBallon(
                key: ValueKey(msgs[idx].id),
                message: msgs[idx],
                belongsToCurrentUser: currentUser?.id == msgs[idx].userId,
              );
            },
            itemCount: msgs.length,
          );
        }
      },
      stream: ChatService().messagesStream(),
    );
  }
}
