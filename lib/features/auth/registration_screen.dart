import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../shared/widgets/custom_button.dart';
import '../shared/widgets/custom_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  String _selectedRole = 'Customer';

  @override
  Widget build(BuildContext context) {
    final db = context.read<MockDatabaseService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Register New Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  prefixIcon: Icons.person,
                  validator: (v) => Validators.validateRequired(v, 'Full Name'),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _mobileController,
                  label: 'Mobile Number',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validateMobile,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  prefixIcon: Icons.email,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _addressController,
                  label: 'Current Address',
                  prefixIcon: Icons.location_on,
                  validator: (v) => Validators.validateRequired(v, 'Address'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedRole,
                  decoration: const InputDecoration(
                    labelText: 'Select Role',
                    prefixIcon: Icon(Icons.badge, color: Color(0xFF1B5E20)),
                  ),
                  items: ['Customer', 'Seller'].map((role) {
                    return DropdownMenuItem(value: role, child: Text(role));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedRole = val!;
                    });
                  },
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Register',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      db.register(
                        _nameController.text,
                        _mobileController.text,
                        _emailController.text,
                        _passwordController.text,
                        _addressController.text,
                        _selectedRole,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registration successful!')),
                      );
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
