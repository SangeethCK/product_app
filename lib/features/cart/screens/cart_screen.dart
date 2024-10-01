import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/features/cart/logic/cart_cubit.dart';
import 'package:mechinetest/features/cart/logic/cart_state.dart';
import 'package:mechinetest/features/cart/screens/widgets/cart_card_widgets.dart';
import 'package:mechinetest/features/cart/screens/widgets/cart_shimmer.dart';
import 'package:mechinetest/shared/appbar/appbar.dart';
import 'package:mechinetest/shared/constants/string_constants.dart';
import 'package:mechinetest/shared/themes/font_palette.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: StringConstants.cart,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state.cartItems == null) {
                  return const CartShimmer();
                } else if (state.cartItems!.isEmpty) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      StringConstants.noItemCart,
                      style: FontPalette.urbenist16,
                    ),
                  ));
                } else {
                  final cartItems = state.cartItems!;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return CartCardWidgets(cartItem: cartItem);
                      },
                    ),
                  );
                }
              },
            ),
            const Spacer(),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                double itemTotal = 0;
                if (state.cartItems != null && state.cartItems!.isNotEmpty) {
                  final cartItems = state.cartItems!;
                  for (var item in cartItems) {
                    itemTotal += item.price * item.quantity;
                  }
                }
                return Column(
                  children: [
                    rowCalculations(StringConstants.itemTotal,
                        itemTotal.toStringAsFixed(2)),
                    35.verticalSpace,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget rowCalculations(String title, String amount) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: FontPalette.urbenist20,
      ),
      Text(
        amount,
        style: FontPalette.urbenist20,
      ),
    ],
  );
}
