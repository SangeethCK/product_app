import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechinetest/features/auth/logic/auth_cubit.dart';
import 'package:mechinetest/features/cart/logic/cart_cubit.dart';
import 'package:mechinetest/features/home/logic/home_logic.dart';
import 'package:mechinetest/my_app.dart';
import 'package:mechinetest/shared/db_helper/helper.dart';
import 'package:mechinetest/shared/dependency_injection/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  await Firebase.initializeApp();
  CartDatabaseHelper();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => getIt<AuthCubit>()),
    BlocProvider(create: (context) => getIt<HomeCubit>()),
    BlocProvider(create: (context) => getIt<CartCubit>()),
  ], child: const MyApp()));
}
