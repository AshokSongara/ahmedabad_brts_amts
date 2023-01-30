import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/card_number_formatter.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/base/custom_toolbar.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  TextEditingController? enterCardNumberController;
  TextEditingController? enterAmountController;

  @override
  void initState() {
    super.initState();
    enterCardNumberController = TextEditingController();
    enterAmountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Column(
          children: [
            const CustomToolbar(
              title: "card_details",
              showOption: false,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 24),
              margin: const EdgeInsets.only(
                  left: Dimensions.dp24,
                  right: Dimensions.dp24,
                  top: Dimensions.dp35),
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
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 19.0, top: 26, right: 18, bottom: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Smart Card Number",
                      textAlign: TextAlign.center,
                      style: satoshiRegular.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    TextField(
                      controller: enterCardNumberController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CardNumberFormatter(),
                      ],
                      style: satoshiRegular.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.darkGray),
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      maxLength: 19,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        errorBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor)),
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        // contentPadding:
                        // const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "EX. 25626 52665 25266",
                        hintStyle: satoshiRegular.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightGray),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Enter Amount",
                      textAlign: TextAlign.center,
                      style: satoshiRegular.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    TextField(
                      controller: enterAmountController,
                      style: satoshiRegular.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.darkGray),
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        errorBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor)),
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        // contentPadding:
                        // const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "EX.500",
                        hintStyle: satoshiRegular.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightGray),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: Dimensions.dp19,
                          right: Dimensions.dp19,
                          top: Dimensions.dp37),
                      child: CustomButton(
                        color: Theme.of(context).primaryColor,
                        text: "Procced To Payment",
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {},
                        style: satoshiRegular.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        height: Dimensions.dp53,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 26),
              child: Text(
                "Its a safe and secure process. We ensure you that we will not share any of your details without your permission.",
                textAlign: TextAlign.center,
                style: satoshiRegular.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
