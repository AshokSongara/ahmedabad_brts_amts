import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/change_password_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/changePassword/change_password_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/changePassword/change_password_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/changePassword/change_password_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_text_field.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/password_text_field.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? number;
  const ResetPasswordScreen({Key? key,required this.number}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _otpController = TextEditingController();
  final FocusNode _otpFocus = FocusNode();

  final _passwordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          listener: (BuildContext context, state) {
            if (state is ChangePasswordLoadingState) {
              Loader.show(context);
            } else if (state is ChangePasswordSuccessState) {
              Loader.hide();
              Get.offNamedUntil(RouteHelper.login,(route) => false);
            } else if (state is ChangePasswordFailedState) {
              Loader.hide();
              showCustomSnackBar(state.errorMessage, context, isError: true);
            } else {
              Loader.hide();
              showCustomSnackBar("Something Went Wrong Try again..!", context,
                  isError: true);
            }
          },
          builder: (context, state) {
            return Column(
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
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Dimensions.dp20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: Dimensions.dp25),
                      child: Row(children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(ImageConstant.iLeftArrow)),
                        Text(
                          "Change Password",
                          style: satoshiRegular.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkGray),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: Dimensions.dp20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: Dimensions.dp35, right: Dimensions.dp35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Otp",
                            style: satoshiRegular.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkGray),
                          ),
                          CustomTextField(
                            textStyle: satoshiRegular.copyWith(
                                color: AppColors.darkGray),
                            controller: _otpController,
                            focusNode: _otpFocus,
                            nextFocus: _passwordFocus,
                            inputType: TextInputType.number,
                            onChanged: () {},
                            onSubmit: () {},
                            capitalization: TextCapitalization.none,
                            divider: false,
                            hintText: "Enter Otp",
                          ),
                          const SizedBox(
                            height: Dimensions.dp20,
                          ),
                          Text(
                            "Password",
                            style: satoshiRegular.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkGray),
                          ),
                          PasswordTextField(
                            isPassword: true,
                            textStyle: satoshiRegular.copyWith(
                                color: AppColors.darkGray),
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            nextFocus: _passwordFocus,
                            inputType: TextInputType.name,
                            onChanged: () {},
                            onSubmit: () {},
                            capitalization: TextCapitalization.words,
                            divider: false,
                            hintText: "Enter Password",
                          ),
                          const SizedBox(
                            height: Dimensions.dp75,
                          ),
                          SizedBox(
                            height: 53,
                            child: CustomButton(
                              color: Theme.of(context).primaryColor,
                              text: "Change Password",
                              width: MediaQuery.of(context).size.width,
                              onPressed: () {
                                RegExp regex = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                                if (_otpController.text.toString().isEmpty) {
                                  showCustomSnackBar(
                                      "Please Otp", context);
                                } else if (_otpController.text
                                    .length > 6 || _otpController.text
                                    .length < 6) {
                                  showCustomSnackBar(
                                      "Otp Length Should be 6 Digits", context);
                                } else if (_passwordController.text.toString().isEmpty) {
                                  showCustomSnackBar("Please Enter Password", context);
                                } else if (_passwordController.text.toString().length <
                                    6) {
                                  showCustomSnackBar(
                                      "Password length should be at least 6 characters",
                                      context);
                                } else if (!regex.hasMatch(_passwordController.text)) {
                                  showCustomSnackBar(
                                      "Password should contain upper,lower,digit and Special character",
                                      context);
                                } else if (_passwordController.text.toString().isEmpty) {
                                  showCustomSnackBar(
                                      "Please Enter Password'", context);
                                } else {
                                  var request = ChangePasswordRequest();
                                  request.number = widget.number;
                                  request.password = _passwordController.text;
                                  request.otp = _otpController.text;
                                  BlocProvider.of<ChangePasswordBloc>(context)
                                      .add(
                                    GetChangePasswordEvent(
                                        changePasswordRequest: request),
                                  );
                                }
                              },
                              style: poppinsMedium.copyWith(
                                  color: Colors.white, fontSize: 15.sp),
                              height: 53,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.dp25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }
}
