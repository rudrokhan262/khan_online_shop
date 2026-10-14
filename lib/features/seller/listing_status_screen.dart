import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';

class ListingStatusScreen extends StatelessWidget {
  const ListingStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final mySubmissions = db.submissions.where((s) => s.sellerId == db.currentUser?.id).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Listing Status & Review')),
      body: mySubmissions.isEmpty
          ? const Center(child: Text('No submissions found.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mySubmissions.length,
              itemBuilder: (context, index) {
                final sub = mySubmissions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(sub.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Chip(
                              label: Text(sub.status, style: const TextStyle(color: Colors.white)),
                              backgroundColor: sub.status == 'Approved'
                                  ? Colors.green
                                  : sub.status == 'Rejected'
                                      ? Colors.red
                                      : Colors.orange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Category: ${sub.category} | Price: ৳${sub.price}'),
                        const SizedBox(height: 4),
                        Text('Authorization: ${sub.authorizationInfo}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        if (sub.adminNotes != null) ...[
                          const SizedBox(height: 8),
                          Text('Admin Notes: ${sub.adminNotes}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
