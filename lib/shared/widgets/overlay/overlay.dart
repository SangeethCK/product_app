import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';


class LoadingOverlay {
  OverlayEntry? _overlay;

  LoadingOverlay();

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        // replace with your own layout
        builder: (context) => const ColoredBox(
          color: Color(0x80000000),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}

class OverlayLoader extends StatelessWidget {
  final Widget child;
  const OverlayLoader({super.key, required this.child});

  @override
  Widget build(BuildContext context) => LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) => Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        )),
        
        overlayColor: Colors.white.withOpacity(0.5),
        child: child,
      );
}
