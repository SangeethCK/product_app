import 'package:equatable/equatable.dart';
import 'package:mechinetest/features/home/domain/model/home_model.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';

class HomeState extends Equatable {
  final ApiFetchStatus homeStatus;
  final ApiFetchStatus cartStatus;
  final List<HomeModel>? homeList;

  final String? error;
  const HomeState(
      {this.homeStatus = ApiFetchStatus.idle,
      this.error,
      this.homeList,
      this.cartStatus = ApiFetchStatus.idle});

  @override
  List<Object?> get props => [homeStatus, error, homeList, cartStatus];

  HomeState copyWith({
    ApiFetchStatus? homeStatus,
    ApiFetchStatus? cartStatus,
    String? error,
    List<HomeModel>? homeList,
  }) =>
      HomeState(
          homeStatus: homeStatus ?? this.homeStatus,
          error: error ?? this.error,
          homeList: homeList ?? this.homeList,
          cartStatus: cartStatus ?? this.cartStatus);
}
