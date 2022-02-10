import 'dart:io';
import 'package:chat_app/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBallon extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;
  static const _defaultImg = 'assets/images/avatar.png';

  MessageBallon({
    Key? key,
    required this.message,
    required this.belongsToCurrentUser,
  });

  Color _getTextColor() {
    return belongsToCurrentUser ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    Widget _showUserImage(String url) {
      ImageProvider? provider;
      final uri = Uri.parse(url);

      if (url.contains(_defaultImg)) {
        provider = AssetImage(_defaultImg);
      } else {
        if (uri.scheme.contains('http')) {
          provider = NetworkImage(uri.toString());
        } else {
          provider = FileImage(File(uri.toString()));
        }
      }

      return CircleAvatar(
        backgroundImage: provider,
      );
    }

    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: belongsToCurrentUser
                        ? Radius.circular(0)
                        : Radius.circular(12),
                    bottomLeft: belongsToCurrentUser
                        ? Radius.circular(12)
                        : Radius.circular(0),
                  ),
                  color: belongsToCurrentUser
                      ? Colors.grey.shade300
                      : Theme.of(context).accentColor),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getTextColor(),
                    ),
                  ),
                  Text(
                    message.text,
                    textAlign:
                        belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      color: _getTextColor(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 165,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(
            message.userImageURL,
          ),
        ),
      ],
    );
  }
}
