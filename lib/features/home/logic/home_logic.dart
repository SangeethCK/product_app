import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mechinetest/features/home/domain/model/home_model.dart';
import 'package:mechinetest/features/home/domain/repository/home_repository.dart';
import 'package:mechinetest/features/home/logic/home_state.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  HomeCubit(this._homeRepository) : super(const HomeState());

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
}
