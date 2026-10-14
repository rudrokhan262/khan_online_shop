import 'package:flutter/material.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms, Privacy & About')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About Khan Commerce Limited', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
            SizedBox(height: 8),
            Text('Khan Commerce Limited is a premier multi-vendor e-commerce application specializing in verified electronics, books, and publications. All vendor listings undergo strict administrative verification before publication.'),
            SizedBox(height: 20),
            Text('Terms & Conditions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
            SizedBox(height: 8),
            Text('Users must provide accurate information. Vendors are responsible for authentic product authorization and compliance with Bangladesh e-commerce regulations.'),
            SizedBox(height: 20),
            Text('Privacy Policy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
            SizedBox(height: 8),
            Text('We safeguard customer and vendor data with secure token authentication and encrypted transmissions.'),
          ],
        ),
      ),
    );
  }
}
