import 'dart:async';

import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_text_field.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/password_text_field.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  StreamController<int>? genderValue = StreamController();

  @override
  void initState() {
    super.initState();
    genderValue?.add(0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            child: AspectRatio(
              aspectRatio: 1 / 0.35,
              child: Container(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.dp20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: Dimensions.dp25),
                child: Row(children: [
                  SvgPicture.asset(ImageConstant.iLeftArrow),
                  Text(
                    "Sign Up",
                    style: satoshiRegular.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkGray),
                  ),
                ]),
              ),
              SizedBox(
                height: Dimensions.dp20,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.dp35, right: Dimensions.dp35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: satoshiRegular.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray),
                    ),
                    CustomTextField(
                      textStyle:
                          satoshiRegular.copyWith(color: AppColors.darkGray),
                      controller: _nameController,
                      focusNode: _nameFocus,
                      nextFocus: _emailFocus,
                      inputType: TextInputType.name,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "John Deo",
                    ),
                    SizedBox(
                      height: Dimensions.dp20,
                    ),
                    Text(
                      "Email",
                      style: satoshiRegular.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray),
                    ),
                    CustomTextField(
                      textStyle:
                          satoshiRegular.copyWith(color: AppColors.darkGray),
                      controller: _emailController,
                      focusNode: _emailFocus,
                      nextFocus: _passwordFocus,
                      inputType: TextInputType.emailAddress,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "johndoe@gmail.com",
                    ),
                    SizedBox(
                      height: Dimensions.dp20,
                    ),
                    Text(
                      "Password",
                      style: satoshiRegular.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray),
                    ),
                    PasswordTextField(
                      isPassword: true,
                      textStyle:
                          satoshiRegular.copyWith(color: AppColors.darkGray),
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      nextFocus: _confirmPasswordFocus,
                      inputType: TextInputType.name,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "******",
                    ),
                    SizedBox(
                      height: Dimensions.dp20,
                    ),
                    Text(
                      "Confirm Password",
                      style: satoshiRegular.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray),
                    ),
                    PasswordTextField(
                      isPassword: true,
                      textStyle:
                          satoshiRegular.copyWith(color: AppColors.darkGray),
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      nextFocus: _confirmPasswordFocus,
                      inputType: TextInputType.name,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "******",
                    ),
                    SizedBox(
                      height: Dimensions.dp20,
                    ),
                    StreamBuilder<int>(
                        stream: genderValue?.stream,
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              Text(
                                "Gender",
                                style: satoshiRegular.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkGray),
                              ),
                              SizedBox(
                                width: Dimensions.dp15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  genderValue?.add(0);
                                },
                                child: SvgPicture.asset(
                                  ImageConstant.iSelectedMan,
                                  color: snapshot.data == 0
                                      ? AppColors.primaryColor
                                      : AppColors.lightGray,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.dp15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  genderValue?.add(1);
                                },
                                child: SvgPicture.asset(
                                    ImageConstant.iSelectedWoman,
                                    color: snapshot.data == 1
                                        ? AppColors.primaryColor
                                        : AppColors.lightGray),
                              ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: Dimensions.dp100,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 30, right: 30, bottom: Dimensions.dp10),
                child: CustomButton(
                  text: "Sign Up",
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    Get.toNamed(RouteHelper.getMobileNumberRoute());
                  },
                  style:
                      poppinsMedium.copyWith(color: Colors.white, fontSize: 15),
                  height: 53,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    genderValue?.close();
  }
}
