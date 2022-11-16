import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/base/custom_search_bar.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({Key? key}) : super(key: key);

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  final _serviceController = TextEditingController();
  final FocusNode _serviceFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Stack(children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            color: AppColors.primaryColor,
            child: Column(children: [
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.dp15, right: Dimensions.dp20),
                padding: EdgeInsets.only(
                    top: Dimensions.dp10, bottom: Dimensions.dp10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageConstant.iLeftArrow,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Near you",
                          style: screenTitle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.dp30,
                    right: Dimensions.dp30,
                    top: Dimensions.dp20),
                child: CustomSearchBar(
                  controller: _serviceController,
                  focusNode: _serviceFocus,
                  nextFocus: _serviceFocus,
                  radius: 10,
                  onChanged: (text) {},
                  onSubmit: () {},
                  prefixIcon: ImageConstant.iSearch,
                  capitalization: TextCapitalization.words,
                  divider: false,
                  hintText: "Nigam Nagar, Chandkheda, Ahmedabad, Gujara...",
                  fillColor: Colors.white,
                  hintStyle: satoshiSmall.copyWith(
                      color: AppColors.lightGray, fontSize: 13),
                ),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
