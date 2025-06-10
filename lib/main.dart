import 'package:flutter/material.dart';
import 'package:untitled1/screens/chat_screen.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:untitled1/screens/notification_screen.dart';
import 'package:untitled1/screens/profile_screen.dart';
import 'package:untitled1/screens/statistics_screen.dart';
import 'package:untitled1/screens/welcome/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
       '/home':(context)=>HomeScreen(),
        '/profile':(context)=>ProfileScreen(),
        '/statistics':(context)=>StatisticsScreen(),
        '/notifications': (context) => NotificationsScreen(),
        '/chats': (context) => ChatsPage(),



      },
      home: WelcomePage(),
      //WelcomePage(),
    );
  }
}