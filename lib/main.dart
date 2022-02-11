import 'package:chat_app/core/services/notification/chat_notification_service.dart';
import 'package:chat_app/pages/auth_or_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        )
      ],
      child: MaterialApp(
        title: 'Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthOrAppScreen(),
      ),
    );
  }
}
