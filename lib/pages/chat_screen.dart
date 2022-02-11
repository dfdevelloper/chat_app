import 'dart:math';

import 'package:chat_app/components/messages.dart';
import 'package:chat_app/components/new_message.dart';
import 'package:chat_app/core/models/chat_notification.dart';
import 'package:chat_app/core/services/auth/auth_service.dart';
import 'package:chat_app/core/services/notification/chat_notification_service.dart';
import 'package:chat_app/pages/notifications_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Sair')
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (dynamic value) {
                if (value == 'logout') AuthService().logout();
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return NotificationScreen();
                    }),
                  );
                },
                icon: Icon(Icons.notifications),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
