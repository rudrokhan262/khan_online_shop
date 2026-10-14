import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../shared/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final results = db.products
        .where((p) => p.isApproved && (p.title.toLowerCase().contains(_query.toLowerCase()) || p.category.toLowerCase().contains(_query.toLowerCase())))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.black87),
          cursorColor: Colors.black87,
          decoration: const InputDecoration(
            hintText: 'Search electronics, books...',
            hintStyle: TextStyle(color: Colors.black87),
            border: InputBorder.none,
          ),
          onChanged: (val) {
            setState(() {
              _query = val;
            });
          },
        ),
      ),
      body: results.isEmpty
          ? const Center(child: Text('No products found matching your search.'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ProductCard(product: results[index]);
              },
            ),
    );
  }
}
