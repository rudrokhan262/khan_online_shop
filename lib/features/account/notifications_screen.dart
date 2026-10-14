import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final notifs = db.notifications;

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: notifs.isEmpty
          ? const Center(child: Text('No notifications'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifs.length,
              itemBuilder: (context, index) {
                final n = notifs[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.notifications_active, color: Color(0xFF1B5E20)),
                    title: Text(n.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(n.body),
                  ),
                );
              },
            ),
    );
  }
}
