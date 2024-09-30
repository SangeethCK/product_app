// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mechinetest/shared/extension/helper.dart';
import 'package:mechinetest/shared/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Helper.afterInit(_initialFunction);
  }

  void _initialFunction() {
    Future.delayed(const Duration(seconds: 4), () async {
      Navigator.pushNamed(context, routeLogin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: const Center(child: Text('Ecomme')),
      ),
    );
  }
}
