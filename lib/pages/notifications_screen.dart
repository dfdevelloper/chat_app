import 'package:chat_app/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas notificações'),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(items[i].title),
          subtitle: Text(items[i].body),
          onTap: () => service.remove(i),
        ),
      ),
    );
  }
}
