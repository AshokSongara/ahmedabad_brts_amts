import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedValue = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.dp40,
            ),
            Row(
              children: [
                Container(
                  height: Dimensions.dp40,
                  width: Dimensions.dp140,
                  margin: const EdgeInsets.only(
                      left: Dimensions.dp20, right: Dimensions.dp30),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gray6E8EE7,
                          blurRadius: 5.0,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(Dimensions.dp50))),
                  child: Container(
                    margin: const EdgeInsets.all(3.0),
                    child: Row(children: [
                      Container(
                        height: Dimensions.dp40,
                          width: Dimensions.dp65,
                          decoration:  BoxDecoration(
                              color: selectedValue == 0 ? AppColors.primaryColor : Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.dp50))),
                          child: Center(
                            child: Text(
                              "AMTS",
                              style: satoshiRegular.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: selectedValue == 0 ? Colors.white : AppColors.darkGray),
                            ),
                          )),
                      Container(
                          height: Dimensions.dp40,
                          width: Dimensions.dp65,
                          decoration:  BoxDecoration(
                              color: selectedValue == 1 ? AppColors.primaryColor : Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.dp50))),
                          child: Center(
                            child: Text(
                              "BRTS",
                              style: satoshiRegular.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: selectedValue == 1 ? Colors.white : AppColors.darkGray),
                            ),
                          )),
                    ]),
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(right: Dimensions.dp20),
                    child: SvgPicture.asset(ImageConstant.iMenu))
              ],
            ),
            SizedBox(
              height: Dimensions.dp20,
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.dp20, right: Dimensions.dp30),
              child: Text(
                "Plan Your Trip",
                style: satoshiRegular.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGray),
              ),
            ),
            SizedBox(
              height: Dimensions.dp15,
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.dp20, right: Dimensions.dp30),
                decoration:  BoxDecoration(
                    color:  Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray6E8EE7,
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.dp50))),
                child: Center(


                ))
          ],
        ));
  }
}
