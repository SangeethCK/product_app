import 'package:flutter/material.dart';
import 'package:mechinetest/features/auth/screens/sign_in/sign_in.dart';
import 'package:mechinetest/features/auth/screens/sign_up/sign_up_screen.dart';
import 'package:mechinetest/features/cart/screens/cart_screen.dart';
import 'package:mechinetest/features/home/screens/home_screen.dart';
import 'package:mechinetest/features/splash/splash_screen.dart';
import 'package:mechinetest/shared/routes/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final Object? args = settings.arguments;

    switch (settings.name) {
      case routeRoot:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case routeSignUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case routeLogin:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case routeHome:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case routeCart:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static Route<dynamic> errorRoute({String? error, bool argsError = false}) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            error ?? '${argsError ? 'Arguments' : 'Navigation'} Error',
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
