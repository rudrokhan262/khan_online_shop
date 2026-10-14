import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Khan Commerce Limited Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
            SizedBox(height: 12),
            Text('For customer support, vendor registration inquiries, or admin listing verification assistance, please contact us at:'),
            SizedBox(height: 12),
            Text('Email: support@khancommerce.com'),
            Text('Hotline: 09612-345678'),
            Text('Head Office: Dhaka, Bangladesh'),
          ],
        ),
      ),
    );
  }
}
