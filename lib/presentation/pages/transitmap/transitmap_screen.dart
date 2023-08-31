import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
                child: PhotoView(
                  backgroundDecoration: const BoxDecoration(
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
                  imageProvider: AssetImage(ImageConstant.iMapImage),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 5.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
