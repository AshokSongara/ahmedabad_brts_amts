import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../widgets/base/custom_toolbar.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Column(
        children: [
          SizedBox(height: Dimensions.dp25),
          CustomToolbar(
            title: "Card Details",
            showOption: false,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 24),
            margin: const EdgeInsets.only(
                left: Dimensions.dp24,
                right: Dimensions.dp24,
                top: Dimensions.dp35),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray6E8EE7,
                  blurRadius: 5.0,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.dp10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
