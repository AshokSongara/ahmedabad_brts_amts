import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PassengerDetails extends StatefulWidget {
  const PassengerDetails({Key? key}) : super(key: key);

  @override
  _PassengerDetailsState createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Column(
        children: [
          SizedBox(height: Dimensions.dp25),
          CustomToolbar(
            title: "Passenger Details",
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
            child: Row(
              children: [
                getSourceDestination("Adalaj Gam", "15 Oct 2022, 10:54 PM"),
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(ImageConstant.iArrowRight),
                ),
                getSourceDestination("Ahm Airport", "15 Oct 2022, 10:54 PM")
              ],
            ),
          ),
          Container(
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
            child: Padding(
              padding: EdgeInsets.only(top: 15, right: 18, left: 18),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Passenger Details",
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGray),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4,horizontal: 9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.dp5,),
                          ),
                          border: Border.all(color: AppColors.primaryColor)
                        ),
                        child: Text("Add Passenger", style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor)),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Adults",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkGray),
                              ),
                              Text(
                                "2",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGray),
                              ),
                            ],
                          ),
                          SizedBox(width: 30,),
                          Column(
                            children: [
                              Text(
                                "Kids",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkGray),
                              ),
                              Text(
                                "2",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGray),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          Text(
                            "Total",
                            style: satoshiRegular.copyWith(
                                fontSize: Dimensions.dp12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGray),
                          ),
                          Text(
                            "2",
                            style: satoshiRegular.copyWith(
                                fontSize: Dimensions.dp16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.darkGray),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSourceDestination(String title, String schedule) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Text(
            title,
            style: satoshiRegular.copyWith(
                fontSize: Dimensions.dp16,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray),
          ),
          Text(schedule,
              style: satoshiRegular.copyWith(
                  fontSize: Dimensions.dp10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray)),
        ],
      ),
    );
  }
}
