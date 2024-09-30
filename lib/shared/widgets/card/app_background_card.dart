import 'package:flutter/material.dart';

class AppBackgroundCard extends StatelessWidget {
  final Widget child;
  const AppBackgroundCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          image: const DecorationImage(
              image: AssetImage('assets/icons/background copy.png'),
              fit: BoxFit.cover),
        ),
        child: child,
      );
}
