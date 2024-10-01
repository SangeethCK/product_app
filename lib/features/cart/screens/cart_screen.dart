import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/features/cart/logic/cart_cubit.dart';
import 'package:mechinetest/features/cart/logic/cart_state.dart';
import 'package:mechinetest/shared/appbar/appbar.dart';
import 'package:mechinetest/shared/constants/colors.dart';
import 'package:mechinetest/shared/db_helper/helper.dart';
import 'package:mechinetest/shared/snackbars/snackbar.dart';
import 'package:mechinetest/shared/themes/font_palette.dart';
import 'package:mechinetest/shared/widgets/decorations/decorations.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'Cart',
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.cartItems == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.cartItems!.isEmpty) {
            return const Center(child: Text('No items in the cart'));
          } else {
            final cartItems = state.cartItems!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];

                return Dismissible(
                  key: Key(cartItem.productId.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) async {
                    await CartDatabaseHelper()
                        .deleteCartItem(cartItem.productId);
                    kSnackBar(
                      color: kRedColor,
                      content: "${cartItem.productName} removed from cart'",
                      success: false,
                    );
                  },
                  child: Container(
                    height: 66.sp,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: cardDecorations,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopify,
                              color: primaryColor,
                              size: 25.sp,
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.productName,
                                    style: FontPalette.urbenist14,
                                  ),
                                  5.verticalSpace,
                                  Text(
                                    'Price: ₹ ${cartItem.price} | Qty: ${cartItem.quantity}',
                                    style: FontPalette.urbenist10
                                        .copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  color: const Color(0xffF3F5F7),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        if (cartItem.quantity > 1) {
                                          final newQuantity =
                                              cartItem.quantity - 1;
                                          context
                                              .read<CartCubit>()
                                              .updateCartItemQuantity(
                                                  cartItem.productId,
                                                  newQuantity);
                                        }
                                      },
                                      icon: const Icon(Icons.remove)),
                                  Text('${cartItem.quantity}'),
                                  IconButton(
                                      onPressed: () async {
                                        final newQuantity =
                                            cartItem.quantity + 1;
                                        context
                                            .read<CartCubit>()
                                            .updateCartItemQuantity(
                                                cartItem.productId,
                                                newQuantity);
                                      },
                                      icon: const Icon(Icons.add))
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
