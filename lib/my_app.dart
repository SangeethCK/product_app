import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/features/auth/screens/sign_in/sign_in.dart';
import 'package:mechinetest/features/home/screens/home_screen.dart';
import 'package:mechinetest/shared/routes/navigator.dart';
import 'package:mechinetest/shared/routes/route_generator.dart';
import 'package:mechinetest/shared/routes/routes.dart';
import 'package:mechinetest/shared/themes/app_theme.dart';

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
            home: const AuthCheck(),
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: 'Mechine_test',
            themeMode: ThemeMode.light,
            theme: AppTheme.lightTheme,
            onGenerateRoute: (settings) =>
                RouteGenerator.generateRoute(settings),
            initialRoute: routeRoot,
            navigatorKey: navigatorKey,
          );
        });
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          if (user != null) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
