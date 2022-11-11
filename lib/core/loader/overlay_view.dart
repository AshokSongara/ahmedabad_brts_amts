import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

const Color overlayBackground = Color(0xff140B21);

class OverlayView {
  static final OverlayView _instance = OverlayView._();

  static OverlayView get instance => _instance;

  OverlayView._();

  factory OverlayView() => _instance;

  var overlayEntry;

  void showOverlay({
    required BuildContext context,
    required Widget childWidget,
    Color? backgroundColor,
    double blur: 4.0,
    Function? onBackgroundTap,
    bool withoutBackdropFilter = false,
  }) {
    if (overlayEntry != null) return;
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return GestureDetector(
        onTap: onBackgroundTap?.call(),
        child: Scaffold(
          backgroundColor:
              backgroundColor ?? overlayBackground.withOpacity(0.7),
          body: withoutBackdropFilter
              ? Center(
                  child: childWidget,
                )
              : BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: Center(
                    child: childWidget,
                  ),
                ),
        ),
      );
    });

    overlayState?.insert(overlayEntry);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();

      overlayEntry = null;
    }
  }
}
