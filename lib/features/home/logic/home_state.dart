import 'package:mechinetest/features/cart/domain/model/cart_model.dart';
import 'package:mechinetest/features/home/domain/model/home_model.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';

class HomeState {
  final ApiFetchStatus homeStatus;
  final ApiFetchStatus cartStatus;
  final List<HomeModel>? homeList;
  final List<CartItem>? cartItems;
  final String? error;

  const HomeState({
    this.homeStatus = ApiFetchStatus.idle,
    this.cartStatus = ApiFetchStatus.idle,
    this.homeList,
    this.cartItems,
    this.error,
  });

  HomeState copyWith({
    ApiFetchStatus? homeStatus,
    ApiFetchStatus? cartStatus,
    List<HomeModel>? homeList,
    List<CartItem>? cartItems,
    String? error,
  }) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
      cartStatus: cartStatus ?? this.cartStatus,
      homeList: homeList ?? this.homeList,
      cartItems: cartItems ?? this.cartItems,
      error: error ?? this.error,
    );
  }

  List<Object?> get props =>
      [homeStatus, cartStatus, homeList, cartItems, error];
}
