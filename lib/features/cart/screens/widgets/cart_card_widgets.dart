import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/features/cart/domain/model/cart_model.dart';
import 'package:mechinetest/features/cart/logic/cart_cubit.dart';
import 'package:mechinetest/shared/constants/colors.dart';
import 'package:mechinetest/shared/snackbars/snackbar.dart';
import 'package:mechinetest/shared/themes/font_palette.dart';
import 'package:mechinetest/shared/widgets/decorations/decorations.dart';

class CartCardWidgets extends StatelessWidget {
  const CartCardWidgets({
    super.key,
    required this.cartItem,
  });

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
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
        context.read<CartCubit>().removeFromCart(cartItem.productId);
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
                        style:
                            FontPalette.urbenist10.copyWith(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      color: const Color(0xffF3F5F7),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            if (cartItem.quantity > 1) {
                              final newQuantity = cartItem.quantity - 1;
                              context.read<CartCubit>().updateCartItemQuantity(
                                  cartItem.productId, newQuantity);
                            }
                          },
                          icon: const Icon(Icons.remove)),
                      Text('${cartItem.quantity}'),
                      IconButton(
                          onPressed: () async {
                            final newQuantity = cartItem.quantity + 1;
                            context.read<CartCubit>().updateCartItemQuantity(
                                cartItem.productId, newQuantity);
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
  }
}
