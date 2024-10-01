import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/features/home/screens/widgets/custome_image.dart';
import 'package:mechinetest/shared/constants/colors.dart';

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
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Color(0xffF3F5F7),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
            height: 100,
            width: 160,
            url: imageUrl,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          10.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("₹ $price",
                      style: const TextStyle(fontSize: 16, color: kRedColor)),
                ),
              ),
              InkWell(
                onTap: () {
                  onTap();
                },
                child: const CircleAvatar(
                  child: Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
