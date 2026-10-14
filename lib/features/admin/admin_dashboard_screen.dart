import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../../core/routes/app_routes.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final pendingCount = db.submissions.where((s) => s.status == 'Pending').length;
    final sellerCount = db.users.where((u) => u.role == 'Seller').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.red.shade800,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Administrator Control Center', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                const SizedBox(height: 8),
                Text('Pending Product Submissions for Review: $pendingCount'),
                const SizedBox(height: 4),
                Text('Active Verified Sellers: $sellerCount'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.verified, color: Colors.red),
            title: const Text('Review Seller Listings'),
            subtitle: const Text('Approve or reject products & books with proper details'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, AppRoutes.adminListingReview),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.people, color: Colors.red),
            title: const Text('Manage Users & Sellers (Ban / Remove)'),
            subtitle: const Text('Remove sellers who violate rules'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, AppRoutes.adminUserManagement),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.red),
            title: const Text('Manage Orders & Payments'),
            subtitle: const Text('Audit transactions and delivery status'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order management module')));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.chat, color: Colors.red),
            title: const Text('Seller In-App Chat'),
            subtitle: const Text('Communicate with vendors'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, AppRoutes.chatConversationList),
          ),
        ],
      ),
    );
  }
}
