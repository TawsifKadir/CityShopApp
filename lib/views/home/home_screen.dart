import 'package:flutter/material.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/components/ui_widgets/product_card.dart';
import 'package:grs/utils/text_styles.dart';

import '../../di.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Clearance Sales Banner
            _buildClearanceBanner(),

            // Categories Section
            _buildCategoriesSection(),

            // Products Grid
            _buildProductsGrid(),

            // Featured Product (Xbox example from your diagram)
            _buildFeaturedProduct(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildClearanceBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text('Clearance Sales', style: sl<TextStyles>().text16_600(primary)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('Up to 50%', style: sl<TextStyles>().text14_500(white)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    const categories = ['All', 'Smartphones', 'Headphones', 'Laptop'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: sl<TextStyles>().text16_600(black)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: categories.map((category) => Chip(
              label: Text(category),
              backgroundColor: category == 'All' ? primary : grey20,
              labelStyle: sl<TextStyles>().text14_500(
                  category == 'All' ? white : black
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      padding: const EdgeInsets.all(16),
      children: const [
        ProductCard(
          name: 'AirPods',
          price: 132.00,
          rating: 4.9,
        ),
        ProductCard(
          name: 'MacBook Air 13',
          price: 1100.00,
          rating: 5.0,
        ),
      ],
    );
  }

  Widget _buildFeaturedProduct() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Xbox Series X', style: sl<TextStyles>().text18_600(black)),
          Row(
            children: [
              const Icon(Icons.star, color: amber, size: 16),
              Text(' 4.8  94% (117 reviews)',
                  style: sl<TextStyles>().text14_400(grey80)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Next-gen gaming console with 120FPS support...',
            style: sl<TextStyles>().text14_400(black),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('\$570.00', style: sl<TextStyles>().text18_600(primary)),
              const Spacer(),
              SizedBox(
                width: 120, // Fixed width
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Add to Cart', style: sl<TextStyles>().text14_500(white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}