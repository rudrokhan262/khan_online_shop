import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/mock_database_service.dart';
import '../../../core/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final user = db.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.fullName ?? 'Guest User'),
            accountEmail: Text(user?.email ?? 'guest@khan.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                (user?.fullName.isNotEmpty == true) ? user!.fullName[0].toUpperCase() : 'G',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF1B5E20),
            ),
            otherAccountsPictures: [
              if (user != null)
                Chip(
                  label: Text(user.role, style: const TextStyle(fontSize: 10, color: Colors.white)),
                  backgroundColor: Colors.green.shade800,
                ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home Marketplace'),
            onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account Information'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.account),
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('My List / My Listings'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.myList),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.cart),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Orders / Purchase History'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.orderHistory),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payment History'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.orderHistory),
          ),
          if (user?.role == 'Seller') ...[
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Seller Dashboard'),
              onTap: () => Navigator.pushNamed(context, AppRoutes.sellerDashboard),
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text('Sell / Submit Product'),
              onTap: () => Navigator.pushNamed(context, AppRoutes.submitProduct),
            ),
            ListTile(
              leading: const Icon(Icons.track_changes),
              title: const Text('Listing Status'),
              onTap: () => Navigator.pushNamed(context, AppRoutes.listingStatus),
            ),
          ],
          if (user?.role == 'Administrator') ...[
            const Divider(),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings, color: Colors.red),
              title: const Text('Admin Dashboard'),
              onTap: () => Navigator.pushNamed(context, AppRoutes.adminDashboard),
            ),
            ListTile(
              leading: const Icon(Icons.verified, color: Colors.red),
              title: const Text('Admin Listing Review'),
              onTap: () => Navigator.pushNamed(context, AppRoutes.adminListingReview),
            ),
          ],
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Seller / Admin Chat'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.chatConversationList),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text("Qur'an"),
            onTap: () => Navigator.pushNamed(context, AppRoutes.quran),
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Prayer Schedule'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.prayer),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Khan Commerce'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.policies),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.helpSupport),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              db.logout();
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
