import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../shared/widgets/product_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String? ?? 'Electronics';
    final db = context.watch<MockDatabaseService>();
    final categoryProducts = db.products.where((p) => p.isApproved && p.category == category).toList();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: categoryProducts.isEmpty
          ? Center(child: Text('No products found in $category'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: categoryProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: categoryProducts[index]);
              },
            ),
    );
  }
}
