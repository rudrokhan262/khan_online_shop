import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../shared/widgets/custom_button.dart';
import '../shared/widgets/custom_text_field.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _addressController;
  String _selectedPaymentMethod = AppConstants.paymentMethods[0];

  @override
  void initState() {
    super.initState();
    final db = context.read<MockDatabaseService>();
    _addressController = TextEditingController(text: db.currentUser?.currentAddress ?? 'Dhaka, Bangladesh');
  }

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout & Payment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _addressController,
                label: 'Delivery Address',
                prefixIcon: Icons.location_on,
                validator: (v) => Validators.validateRequired(v, 'Address'),
              ),
              const SizedBox(height: 24),
              const Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
              const SizedBox(height: 12),
              ...AppConstants.paymentMethods.map((method) {
                return RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (val) {
                    setState(() {
                      _selectedPaymentMethod = val!;
                    });
                  },
                );
              }),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Items Subtotal:'),
                        Text('৳${db.cartSubtotal.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery Charge:'),
                        Text('৳100.00'),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('৳${(db.cartSubtotal + 100).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1B5E20))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Confirm & Pay ($_selectedPaymentMethod)',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final order = db.placeOrder(
                      deliveryAddress: _addressController.text,
                      paymentMethod: _selectedPaymentMethod,
                    );
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.orderConfirmation,
                      arguments: order,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
