import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../shared/widgets/custom_button.dart';
import '../shared/widgets/custom_text_field.dart';

class SubmitProductScreen extends StatefulWidget {
  const SubmitProductScreen({super.key});

  @override
  State<SubmitProductScreen> createState() => _SubmitProductScreenState();
}

class _SubmitProductScreenState extends State<SubmitProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();
  final _authController = TextEditingController();
  String _selectedCategory = AppConstants.categories[0];

  @override
  Widget build(BuildContext context) {
    final db = context.read<MockDatabaseService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Submit Product / Book')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _titleController,
                label: 'Product / Book Title',
                prefixIcon: Icons.title,
                validator: (v) => Validators.validateRequired(v, 'Title'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category, color: Color(0xFF1B5E20)),
                ),
                items: AppConstants.categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedCategory = val!;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _priceController,
                label: 'Price (BDT)',
                prefixIcon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: (v) => Validators.validateRequired(v, 'Price'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _descController,
                label: 'Description & Specifications',
                prefixIcon: Icons.description,
                validator: (v) => Validators.validateRequired(v, 'Description'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _imageController,
                label: 'Image URL (optional)',
                prefixIcon: Icons.image,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _authController,
                label: 'Authorization / Authenticity Information',
                prefixIcon: Icons.verified,
                validator: (v) => Validators.validateRequired(v, 'Authorization Info'),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Submit to Admin for Approval',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    db.submitProduct(
                      title: _titleController.text,
                      category: _selectedCategory,
                      price: double.tryParse(_priceController.text) ?? 0.0,
                      description: _descController.text,
                      imageUrl: _imageController.text,
                      authorizationInfo: _authController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Product submitted successfully! Awaiting admin review.')),
                    );
                    Navigator.pushReplacementNamed(context, AppRoutes.listingStatus);
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
