import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../../core/routes/app_routes.dart';

class SellerDashboardScreen extends StatelessWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final mySubmissions = db.submissions.where((s) => s.sellerId == db.currentUser?.id).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Seller Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Vendor Portal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
                  SizedBox(height: 8),
                  Text('Submit products and books for admin verification before publishing to marketplace.'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('My Submissions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Submit Product'),
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.submitProduct),
                ),
              ],
            ),
            const SizedBox(height: 12),
            mySubmissions.isEmpty
                ? const Center(child: Text('No submissions yet.'))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mySubmissions.length,
                    itemBuilder: (context, index) {
                      final sub = mySubmissions[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(sub.title),
                          subtitle: Text('Category: ${sub.category} | Price: ৳${sub.price}'),
                          trailing: Chip(
                            label: Text(sub.status, style: const TextStyle(fontSize: 11, color: Colors.white)),
                            backgroundColor: sub.status == 'Approved' ? Colors.green : Colors.orange,
                          ),
                          onTap: () => Navigator.pushNamed(context, AppRoutes.listingStatus),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
