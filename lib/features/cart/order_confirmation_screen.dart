import 'package:flutter/material.dart';
import '../../models/cart_order_model.dart';
import '../../core/routes/app_routes.dart';
import '../shared/widgets/custom_button.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Color(0xFF1B5E20)),
              const SizedBox(height: 16),
              const Text(
                'Order Placed Successfully!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
              ),
              const SizedBox(height: 8),
              Text('Order ID: ${order.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('Payment via ${order.paymentMethod}: Successful', style: const TextStyle(color: Colors.green)),
              const SizedBox(height: 24),
              CustomButton(
                text: 'View Order History',
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.orderHistory),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false),
                child: const Text('Back to Home', style: TextStyle(color: Color(0xFF1B5E20))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
