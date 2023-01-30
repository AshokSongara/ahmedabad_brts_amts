import 'package:ahmedabad_brts_amts/core/theme/theme_service.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocalModel {
  String name;
  String price;
  bool isChecked;
  bool isEnable;

  LocalModel(this.name, this.price, this.isChecked, this.isEnable);
}

class OneDayPassScreen extends StatefulWidget {
  const OneDayPassScreen({Key? key}) : super(key: key);

  @override
  _OneDayPassScreenState createState() => _OneDayPassScreenState();
}

class _OneDayPassScreenState extends State<OneDayPassScreen> {
  List<LocalModel> list = [];

  @override
  void initState() {
    super.initState();
    list.add(LocalModel("Adult Ticket", "₹50.00", true, true));
    list.add(LocalModel("Ladies Ticket", "₹30.00", false, true));
    list.add(LocalModel("Child Ticket", "₹20.00", false, true));
    list.add(LocalModel("Adult Ticket for Sunday", "₹50.00", false, false));
    list.add(LocalModel("Ladies Ticket for Sunday", "₹30.00", false, false));
    list.add(LocalModel("Child Ticket for Sunday", "₹20.00", false, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: Dimensions.dp25),
            const CustomToolbar(
              title: "One Day Pass",
            ),
            const SizedBox(
              height: Dimensions.dp10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 29,
              ),
              margin: const EdgeInsets.only(
                  left: Dimensions.dp24, right: Dimensions.dp24),
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
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            list[index].isChecked = !list[index].isChecked;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    list[index].isChecked && list[index].isEnable
                                        ? SvgPicture.asset(
                                            ThemeService().theme == ThemeMode.light
                                                ? ImageConstant.iRedTick
                                                : ImageConstant.iBlueTick,
                                          )
                                        : SvgPicture.asset(
                                            ImageConstant.iGreyTick,
                                          ),
                                    const SizedBox(
                                      width: Dimensions.dp23,
                                    ),
                                    Text(
                                      list[index].name,
                                      style: satoshiRegular.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: list[index].isEnable
                                              ? AppColors.darkGray
                                              : AppColors.profileBackgroundGrey),
                                    ),
                                  ],
                                ),
                                Text(
                                  list[index].price,
                                  style: satoshiRegular.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.profileBackgroundGrey),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: Dimensions.dp10,
                        right: Dimensions.dp10,
                        top: Dimensions.dp14),
                    child: CustomButton(
                      color: Theme.of(context).primaryColor,
                      text: "Procced To Payment",
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {},
                      style: satoshiRegular.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      height: Dimensions.dp53,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
