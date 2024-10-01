import 'package:mechinetest/features/cart/domain/model/cart_model.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';

class CartState {
  final ApiFetchStatus cartStatus;
  final ApiFetchStatus? cartLoad;

  final List<CartItem>? cartItems;
  final String? error;

  const CartState({
    this.cartStatus = ApiFetchStatus.idle,
    this.cartItems,
    this.cartLoad,
    this.error,
  });

  CartState copyWith({
    ApiFetchStatus? homeStatus,
    ApiFetchStatus? cartStatus,
    List<CartItem>? cartItems,
    ApiFetchStatus? cartLoad,
    String? error,
  }) {
    return CartState(
        cartStatus: cartStatus ?? this.cartStatus,
        cartItems: cartItems ?? this.cartItems,
        error: error ?? error,
        cartLoad: cartLoad ?? this.cartLoad);
  }

  List<Object?> get props => [cartStatus, cartItems, error];
}
