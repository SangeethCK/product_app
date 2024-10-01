import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 66,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  color: Colors.grey,
                  margin: const EdgeInsets.all(12),
                ),
                Expanded(
                  child: Container(
                    height: 14,
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ),
                Container(
                  width: 60,
                  height: 20,
                  color: Colors.grey,
                  margin: const EdgeInsets.all(12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
