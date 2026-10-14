import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../../core/constants/app_constants.dart';

class AdminListingReviewScreen extends StatelessWidget {
  const AdminListingReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final pendingSubmissions = db.submissions.where((s) => s.status == AppConstants.statusPending).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Listing Review'),
        backgroundColor: Colors.red.shade800,
      ),
      body: pendingSubmissions.isEmpty
          ? const Center(child: Text('No pending listings to review.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pendingSubmissions.length,
              itemBuilder: (context, index) {
                final sub = pendingSubmissions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(sub.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 8),
                        Text('Category: ${sub.category} | Price: ৳${sub.price}'),
                        const SizedBox(height: 4),
                        Text('Authorization Info: ${sub.authorizationInfo}', style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              icon: const Icon(Icons.close, color: Colors.red),
                              label: const Text('Reject', style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                db.updateSubmissionStatus(sub.id, AppConstants.statusRejected, adminNotes: 'Did not meet compliance criteria.');
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Listing Rejected')));
                              },
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              icon: const Icon(Icons.check),
                              label: const Text('Approve'),
                              onPressed: () {
                                db.updateSubmissionStatus(sub.id, AppConstants.statusApproved, adminNotes: 'Verified and approved for marketplace.');
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Listing Approved & Published!')));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
