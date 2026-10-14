import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../../core/routes/app_routes.dart';

class ChatConversationListScreen extends StatelessWidget {
  const ChatConversationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final isSeller = db.currentUser?.role == 'Seller';
    final targetId = isSeller ? 'u3' : 'u2';
    final targetName = isSeller ? 'Admin Khan Commerce' : 'Seller Electronics Ltd';

    return Scaffold(
      appBar: AppBar(title: const Text('Seller / Admin Chat')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFF1B5E20),
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(targetName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Tap to open conversation and discuss listing verification'),
            trailing: const Icon(Icons.chat_bubble_outline),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.chat,
                arguments: {'targetId': targetId, 'targetName': targetName},
              );
            },
          ),
        ],
      ),
    );
  }
}
