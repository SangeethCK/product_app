
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mechinetest/shared/constants/colors.dart';
import 'package:mechinetest/shared/constants/image.dart';
import 'package:mechinetest/shared/constants/string_constants.dart';
import 'package:mechinetest/shared/extension/helper.dart';
import 'package:mechinetest/shared/routes/routes.dart';
import 'package:mechinetest/shared/themes/font_palette.dart';

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
      body: Stack(
        children: [
          Image.asset(
            Assets.splash,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                StringConstants.wlcm,
                style: FontPalette.urbenist34.copyWith(color: kWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
