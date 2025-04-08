import 'package:flutter/material.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/utils/text_styles.dart';

import '../../di.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final double rating;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: grey20,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.image, color: grey60, size: 40),
              ),
            ),
            const SizedBox(height: 8),

            // Product Name
            Text(name, style: sl<TextStyles>().text14_600(black)),

            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: amber, size: 16),
                Text(' $rating', style: sl<TextStyles>().text12_400(grey80)),
              ],
            ),

            // Price
            Text('\$$price',
                style: sl<TextStyles>().text16_600(primary)),
          ],
        ),
      ),
    );
  }
}