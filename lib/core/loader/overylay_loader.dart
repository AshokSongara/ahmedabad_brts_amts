import 'dart:ui';

import 'package:ahmedabad_brts_amts/core/loader/loading_animation.dart';
import 'package:flutter/material.dart';

class Loader {
  static OverlayEntry? _currentLoader;

  Loader._();

  static OverlayState? _overlayState;

  static bool _isShowing = false;

  static double _blur = 7.0;
  static double _opacity = 0.7;
  static double _boxRadius = 10.0;
  static double _boxPadding = 16.0;

  static void show(BuildContext context, {bool backdropFilter = true}) {
    _isShowing = true;
    _overlayState = Overlay.of(context);
    if (_currentLoader == null) {
      _currentLoader = OverlayEntry(builder: (context) {
        return Scaffold(
          backgroundColor: Color(0xff140B21).withOpacity(_opacity),
          body: backdropFilter
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(_boxPadding),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.all(
                          Radius.circular(_boxRadius),
                        ),
                      ),
                      child: LoadingAnimation(),
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    padding: EdgeInsets.all(_boxPadding),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(
                        Radius.circular(_boxRadius),
                      ),
                    ),
                    child: LoadingAnimation(),
                  ),
                ),
        );
      });
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => {
          if (_isShowing) _overlayState?.insertAll([_currentLoader!])
        },
      );
    }
  }

  static void hide() {
    if (_currentLoader != null) {
      try {
        _currentLoader?.remove();
      } catch (e) {
      } finally {
        _currentLoader = null;
        _isShowing = false;
      }
    }
  }

  static bool isShowing() {
    return _isShowing;
  }
}