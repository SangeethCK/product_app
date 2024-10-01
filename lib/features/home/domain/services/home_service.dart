import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mechinetest/features/home/domain/model/home_model.dart';
import 'package:mechinetest/shared/api/networks/network.dart';

import '../repository/home_repository.dart';
@LazySingleton(as: HomeRepository)

class HomeService implements HomeRepository {
  @override
  Future<List<HomeModel>> getHome() async {
    final Response response = await NetworkProvider().get(
      'https://beta.orderies.com/api/category-products?store_id=13&page_first_result=0&result_per_page=30',
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<HomeModel>.from(
          response.data.map((e) => HomeModel.fromJson(e)));
    } else {
      throw Exception('error');
    }
  }
}
