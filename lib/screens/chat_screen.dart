import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../widgets/drawer.dart';
import 'new_chat.dart';


class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data to simulate fetching from database
    final List<Map<String, dynamic>> chatData = [
      {
        'name': 'Chat 1',
        'lastMessage': 'مرحبا، كيف حالك؟',
        'hasVideo': true,
      },
      {
        'name': 'Chat 2',
        'lastMessage': 'أريد شراء منتج معين',
        'hasVideo': false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Chats', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textPrimary),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ...chatData.map((chat) => ChatTile(
            name: chat['name'],
            lastMessage: chat['lastMessage'],
            hasVideo: chat['hasVideo'],
            onTap: () {},
          )),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NewChatPage()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Start New Chat'),
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final bool hasVideo;
  final VoidCallback onTap;

  const ChatTile({
    Key? key,
    required this.name,
    required this.lastMessage,
    required this.hasVideo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        onTap: onTap,
        title: Text(name, style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: [
            Expanded(child: Text(lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.textSecondary))),
            if (hasVideo) const Icon(Icons.video_library, color: Colors.blueAccent, size: 20),
          ],
        ),
      ),
    );
  }
}