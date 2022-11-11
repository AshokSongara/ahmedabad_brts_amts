import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final String iconPath;
  final double width;
  final double height;
  final double radius;
  final TextStyle style;
  final void Function() onPressed;

  const CustomButton({
    Key? key,
    this.iconPath = "",
    this.color = AppColors.primaryColor,
    required this.text,
    required this.onPressed,
    required this.width,
    this.radius = 8.0,
    required this.style,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
             Radius.circular(10)),
        ),
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
