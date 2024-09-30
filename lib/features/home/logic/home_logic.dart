import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mechinetest/features/cart/domain/model/cart_model.dart';
import 'package:mechinetest/features/home/domain/model/home_model.dart';
import 'package:mechinetest/features/home/domain/repository/home_repository.dart';
import 'package:mechinetest/features/home/domain/services/home_service.dart';
import 'package:mechinetest/features/home/logic/home_state.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';
import 'package:mechinetest/shared/db_helper/helper.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository = HomeService();

  HomeCubit() : super(const HomeState());

  Future<void> fetchHomeProducts() async {
    try {
      emit(state.copyWith(homeStatus: ApiFetchStatus.loading));
      final List<HomeModel> homeList = await _homeRepository.getHome();
      emit(state.copyWith(
        homeStatus: ApiFetchStatus.success,
        homeList: homeList,
      ));
    } catch (e) {
      emit(state.copyWith(
        homeStatus: ApiFetchStatus.failed,
        error: 'Failed to fetch products: ${e.toString()}',
      ));
    }
  }

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

  Future<List<CartItem>> getCartItems() async {
    return await CartDatabaseHelper().getCartItems();
  }
}
