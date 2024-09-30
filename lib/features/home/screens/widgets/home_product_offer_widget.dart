import 'package:flutter/material.dart';
import 'package:mechinetest/features/home/screens/widgets/custome_image.dart';
import 'package:mechinetest/shared/consrants/colors.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String quantity;
  final VoidCallback onTap;

  const ProductCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.price,
      required this.quantity,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              height: 70,
              width: 160,
              url: imageUrl,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(price,
                    style: const TextStyle(fontSize: 16, color: kBlack)),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  onTap();
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kColorLight4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
