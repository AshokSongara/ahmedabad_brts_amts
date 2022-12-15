import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotationController,
      builder: (_, child) {
        return Transform.rotate(
          angle: rotationController.value * 2 * math.pi,
          child: child,
        );
      },
      child: SvgPicture.asset(
        ImageConstant.iLoader,
        width: 40,
        height: 40,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
