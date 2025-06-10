import 'package:flutter/material.dart';
import 'package:untitled1/core/constants/colors.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Header section with logo and title
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors. primaryOpacity20, // Background color for the header
            ),
            accountName: Text('Glosign', style: TextStyle(fontSize: 20,color: Colors.black)),
            accountEmail: Text('Sign Language', style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.background,
              child: Icon(Icons.sign_language, color: Colors.blue),
            ),
          ),

          // List of menu items
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outlined),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Statistics'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/statistics');
            },
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble_outline),
            title: Text('Chats'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/chats');
            },
          ),

          // Logout button
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout', style: TextStyle(color: Colors.black)),
            //tileColor: Colors.white,
            onTap: () {
              // Implement logout logic here
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}