import 'package:mechinetest/features/cart/domain/model/cart_model.dart';
import 'package:mechinetest/features/home/domain/model/home_model.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';

class CartState {
  final ApiFetchStatus cartStatus;
  final List<HomeModel>? homeList;
  final List<CartItem>? cartItems;
  final String? error;

  const CartState({
    this.cartStatus = ApiFetchStatus.idle,
    this.homeList,
    this.cartItems,
    this.error,
  });

  CartState copyWith({
    ApiFetchStatus? homeStatus,
    ApiFetchStatus? cartStatus,
    List<HomeModel>? homeList,
    List<CartItem>? cartItems,
    String? error,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      homeList: homeList ?? this.homeList,
      cartItems: cartItems ?? this.cartItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [cartStatus, homeList, cartItems, error];
}
