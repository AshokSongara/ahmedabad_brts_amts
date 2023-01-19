import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:flutter/material.dart';

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.stroke;
    //a circle
    canvas.drawCircle(const Offset(0, 0), 7, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}