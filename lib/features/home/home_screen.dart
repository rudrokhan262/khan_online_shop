import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../shared/widgets/app_drawer.dart';
import '../shared/widgets/product_card.dart';
import '../shared/widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final approvedProducts = db.products.where((p) => p.isApproved).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
              ),
              if (db.cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                    child: Text(
                      '${db.cartItems.length}',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Khan Commerce',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Verified Electronics & Books from Trusted Vendors',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.categories.length,
                itemBuilder: (context, index) {
                  final cat = AppConstants.categories[index];
                  return CategoryCard(
                    categoryName: cat,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.categories, arguments: cat);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Approved Marketplace Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            approvedProducts.isEmpty
                ? const Center(child: Text('No approved products available right now.'))
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: approvedProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: approvedProducts[index]);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
