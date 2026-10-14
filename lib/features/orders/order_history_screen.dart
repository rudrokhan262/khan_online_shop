import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final orders = db.orders;

    return Scaffold(
      appBar: AppBar(title: const Text('Order & Payment History')),
      body: orders.isEmpty
          ? const Center(
              child: Text('No orders placed yet.', style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Chip(
                              label: Text(order.orderStatus, style: const TextStyle(fontSize: 12, color: Colors.white)),
                              backgroundColor: const Color(0xFF1B5E20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Total: ৳${order.totalAmount.toStringAsFixed(2)} (${order.paymentMethod})'),
                        const SizedBox(height: 4),
                        Text('Address: ${order.deliveryAddress}', style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                        const SizedBox(height: 8),
                        const Divider(),
                        const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ...order.items.map((i) => Text('- ${i.product.title} (x${i.quantity})', style: const TextStyle(fontSize: 13))),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
