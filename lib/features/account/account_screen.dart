import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final user = db.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Account Information')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Color(0xFF1B5E20), child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 16),
            Text(user?.fullName ?? 'User', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(user?.email ?? '', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Mobile Number'),
                subtitle: Text(user?.mobileNumber ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Current Address'),
                subtitle: Text(user?.currentAddress ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.badge),
                title: const Text('Account Role'),
                subtitle: Text(user?.role ?? 'Customer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
