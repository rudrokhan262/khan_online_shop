import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../shared/widgets/custom_button.dart';
import '../shared/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'customer@khan.com');
  final _passwordController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag, size: 80, color: Color(0xFF1B5E20)),
                  const SizedBox(height: 16),
                  const Text(
                    'Khan Commerce Limited',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Multi-Vendor E-Commerce Platform',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
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
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final db = context.read<MockDatabaseService>();
                        bool success = db.login(_emailController.text, _passwordController.text);
                        if (success) {
                          Navigator.pushReplacementNamed(context, AppRoutes.home);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid email or password')),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.registration);
                    },
                    child: const Text('Don\'t have an account? Register here', style: TextStyle(color: Color(0xFF1B5E20))),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
