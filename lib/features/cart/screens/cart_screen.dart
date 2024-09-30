import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechinetest/features/cart/domain/model/cart_model.dart';
import 'package:mechinetest/features/home/logic/home_logic.dart';
import 'package:mechinetest/features/home/logic/home_state.dart';
import 'package:mechinetest/shared/themes/font_palette.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return FutureBuilder<List<CartItem>>(
            future: context.read<HomeCubit>().getCartItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No items in the cart'));
              } else {
                final cartItems = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          cartItem.productName,
                          style: FontPalette.urbenist14,
                        ),
                        subtitle: Text(
                          'Price: \$${cartItem.price} | Qty: ${cartItem.quantity}',
                          style: FontPalette.urbenist10,
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
