import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(String message, BuildContext context,
    {bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.only(
        right: Dimensions.dp10,
        top: Dimensions.dp10,
        bottom: Dimensions.dp10,
        left: Dimensions.dp10,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      content:
          Text(message, style: satoshiRegular),
    ));
  }
}
