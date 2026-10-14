import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';

class AdminUserManagementScreen extends StatelessWidget {
  const AdminUserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final sellersAndUsers = db.users.where((u) => u.role != 'Administrator').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users & Sellers (Rule Violations)'),
        backgroundColor: Colors.red.shade800,
      ),
      body: sellersAndUsers.isEmpty
          ? const Center(child: Text('No users found.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sellersAndUsers.length,
              itemBuilder: (context, index) {
                final user = sellersAndUsers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: user.role == 'Seller' ? Colors.orange.shade100 : Colors.green.shade100,
                      child: Icon(
                        user.role == 'Seller' ? Icons.store : Icons.person,
                        color: user.role == 'Seller' ? Colors.orange.shade800 : Colors.green.shade800,
                      ),
                    ),
                    title: Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${user.email} • Role: ${user.role}\nMobile: ${user.mobileNumber}'),
                    isThreeLine: true,
                    trailing: user.role == 'Seller'
                        ? IconButton(
                            icon: const Icon(Icons.delete_forever, color: Colors.red),
                            tooltip: 'Remove Seller for Rule Violation',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Remove Seller?'),
                                  content: Text('Are you sure you want to remove seller "${user.fullName}" for violating platform rules? All their products and submissions will be removed.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                      onPressed: () {
                                        db.removeSeller(user.id);
                                        Navigator.pop(ctx);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Seller ${user.fullName} removed successfully.')),
                                        );
                                      },
                                      child: const Text('Remove'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : null,
                  ),
                );
              },
            ),
    );
  }
}
