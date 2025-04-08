import 'package:flutter/material.dart';
import 'package:grs/components/app_buttons/app_button.dart';
import 'package:grs/components/ui_widgets/bottom_navbar.dart';
import '../components/ui_widgets/selection_chip.dart';
import '../enum/enums.dart';

class ComponentDemoScreen extends StatefulWidget {
  const ComponentDemoScreen({super.key});

  @override
  State<ComponentDemoScreen> createState() => _ComponentDemoScreenState();
}

class _ComponentDemoScreenState extends State<ComponentDemoScreen> {
  int _currentIndex = 0;
  String? _selectedCategory;
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Library'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Chips
            _buildSectionTitle('Filter Chips'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                SelectionChip(
                  label: 'All Products',
                  isSelected: _selectedCategory == null,
                  onSelected: (_) => setState(() => _selectedCategory = null),
                ),
                SelectionChip(
                  label: 'Smartphones',
                  isSelected: _selectedCategory == 'Smartphones',
                  onSelected: (_) => setState(() => _selectedCategory = 'Smartphones'),
                  leadingIcon: const Icon(Icons.phone_iphone, size: 18),
                ),
                SelectionChip(
                  label: 'Laptops',
                  isSelected: _selectedCategory == 'Laptops',
                  onSelected: (_) => setState(() => _selectedCategory = 'Laptops'),
                  leadingIcon: const Icon(Icons.laptop, size: 18),
                ),
                SelectionChip(
                  label: 'Headphones',
                  isSelected: _selectedCategory == 'Headphones',
                  onSelected: (_) => setState(() => _selectedCategory = 'Headphones'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section 2: Buttons
            _buildSectionTitle('Buttons'),
            AppButton(
              text: 'Primary Button',
              onPressed: () => _showSnackbar('Primary clicked'),
              variant: ButtonVariant.primary,
            ),
            const SizedBox(height: 12),
            AppButton(
              text: 'Secondary Button',
              onPressed: () => _showSnackbar('Secondary clicked'),
              variant: ButtonVariant.secondary,
            ),
            const SizedBox(height: 12),
            AppButton(
              text: 'Compact Button',
              onPressed: () => _showSnackbar('Compact clicked'),
              isFullWidth: false,
              leadingIcon: const Icon(Icons.add),
            ),
            const SizedBox(height: 24),

            // Section 3: Counter Demo
            _buildSectionTitle('Interactive Demo'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Counter: $_counter', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Decrease',
                            onPressed: () => setState(() => _counter--),
                            variant: ButtonVariant.secondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            text: 'Increase',
                            onPressed: () => setState(() => _counter++),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.pink,
      ),
    );
  }
}