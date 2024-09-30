import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/shared/routes/navigator.dart';
import 'package:mechinetest/shared/routes/route_generator.dart';
import 'package:mechinetest/shared/routes/routes.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp(
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: 'Mechine_test',
            themeMode: ThemeMode.light,
            onGenerateRoute: (settings) =>
                RouteGenerator.generateRoute(settings),
            initialRoute: routeRoot,
            navigatorKey: navigatorKey,
          );
        });
  }
}
