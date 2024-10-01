// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/logic/auth_cubit.dart' as _i259;
import '../../features/cart/logic/cart_cubit.dart' as _i114;
import '../../features/home/domain/repository/home_repository.dart' as _i541;
import '../../features/home/domain/services/home_service.dart' as _i677;
import '../../features/home/logic/home_logic.dart' as _i289;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i259.AuthCubit>(() => _i259.AuthCubit());
    gh.factory<_i114.CartCubit>(() => _i114.CartCubit());
    gh.lazySingleton<_i541.HomeRepository>(() => _i677.HomeService());
    gh.factory<_i289.HomeCubit>(
        () => _i289.HomeCubit(gh<_i541.HomeRepository>()));
    return this;
  }
}
