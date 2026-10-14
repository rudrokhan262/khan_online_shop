import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Stepper(
              physics: const NeverScrollableScrollPhysics(),
              currentStep: 1,
              steps: const [
                Step(title: Text('Order Placed'), content: Text('Your order has been placed successfully.'), isActive: true),
                Step(title: Text('Verified & Processing'), content: Text('Admin has verified payment and order processing.'), isActive: true),
                Step(title: Text('Shipped'), content: Text('Dispatched via courier partner.'), isActive: false),
                Step(title: Text('Delivered'), content: Text('Delivered to your address.'), isActive: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
