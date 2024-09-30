import 'package:mechinetest/features/home/domain/model/home_model.dart';

abstract class HomeRepository {
  const HomeRepository();

  Future<List<HomeModel>> getHome();
}
