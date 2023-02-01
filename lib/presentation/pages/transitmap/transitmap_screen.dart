import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:flutter/material.dart';

class TransitMapScreen extends StatelessWidget {
  const TransitMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: SafeArea(
        child: Column(
          children: [
            const CustomToolbar(
              title: "transit_map",
              showOption: false,
            ),
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: Dimensions.dp24,
                      right: Dimensions.dp24,),
                  decoration: const BoxDecoration(
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
                  child:
                      InteractiveViewer(child: Image.network(AppConstant.transitMap)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
