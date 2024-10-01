import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechinetest/features/cart/domain/model/cart_model.dart';
import 'package:mechinetest/features/cart/logic/cart_state.dart';
import 'package:mechinetest/features/home/domain/model/home_model.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';
import 'package:mechinetest/shared/db_helper/helper.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());
//=-=-=-=-=-=-= Add to cart =-=-=-=-=-=-=-=
  Future<void> addToCart(HomeModel product) async {
    try {
      emit(state.copyWith(cartStatus: ApiFetchStatus.loading));
      final cartItem = CartItem(
        productId: product.productId ?? 0,
        productName: product.displayProductName ?? '',
        price: double.tryParse(product.productPrice ?? '0.0') ?? 0.0,
        quantity: 1,
      );
      await CartDatabaseHelper().insertCartItem(cartItem);
      emit(state.copyWith(cartStatus: ApiFetchStatus.success));
    } catch (e) {
      emit(state.copyWith(cartStatus: ApiFetchStatus.failed));
      log("Error adding to cart: $e");
    }
  }
//=-=-=-=-=-=-= Get cart =-=-=-=-=-=-=-=

  Future<void> getCartItems() async {
    try {
      final cartItems = await CartDatabaseHelper().getCartItems();
      emit(state.copyWith(
          cartItems: cartItems, cartLoad: ApiFetchStatus.success));
    } catch (e) {
      emit(state.copyWith(cartLoad: ApiFetchStatus.failed));
    }
  }
//=-=-=-=-=-=-= Update cart =-=-=-=-=-=-=-=

  Future<void> updateCartItemQuantity(int productId, int newQuantity) async {
    try {
      await CartDatabaseHelper().updateCartItemQuantity(productId, newQuantity);
      final updatedCartItems = await CartDatabaseHelper().getCartItems();
      emit(state.copyWith(
          cartItems: updatedCartItems, cartLoad: ApiFetchStatus.success));
    } catch (e) {
      emit(state.copyWith(cartLoad: ApiFetchStatus.failed));
    }
  }
  //=-=-=-=-=-=-= Remove cart =-=-=-=-=-=-=-=

  Future<void> removeFromCart(int productId) async {
    try {
      await CartDatabaseHelper().deleteCartItem(productId);
      await getCartItems();
    } catch (e) {
      emit(state.copyWith(cartLoad: ApiFetchStatus.failed));
      log("Error removing from cart: $e");
    }
  }
  //=-=-=-=-=-=-= Reset =-=-=-=-=-=-=-=

  void reset() {
    emit(const CartState());
  }
}
