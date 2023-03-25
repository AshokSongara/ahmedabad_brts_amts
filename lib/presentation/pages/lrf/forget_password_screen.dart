import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/forget_password_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/forgetpassword/forget_password_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/forgetpassword/forget_password_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/forgetpassword/forget_password_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_text_field.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
          listener: (BuildContext context, state) {
            if (state is ForgetPasswordLoadingState) {
              Loader.show(context);
            } else if (state is ForgetPasswordSuccessState) {
              Loader.hide();
              Get.toNamed(RouteHelper.resetPassword);
            } else if (state is ForgetPasswordFailedState) {
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
                          "Forget Password",
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
                            "Mobile Number",
                            style: satoshiRegular.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkGray),
                          ),
                          CustomTextField(
                            textStyle: satoshiRegular.copyWith(
                                color: AppColors.darkGray),
                            controller: _emailController,
                            focusNode: _emailFocus,
                            nextFocus: _emailFocus,
                            inputType: TextInputType.number,
                            onChanged: () {},
                            onSubmit: () {},
                            capitalization: TextCapitalization.none,
                            divider: false,
                            hintText: "Enter Mobile Number",
                          ),
                          const SizedBox(
                            height: Dimensions.dp75,
                          ),
                          SizedBox(
                            height: 53,
                            child: CustomButton(
                              color: Theme.of(context).primaryColor,
                              text: "Forget Password",
                              width: MediaQuery.of(context).size.width,
                              onPressed: () {
                                if (_emailController.text.toString().isEmpty) {
                                  showCustomSnackBar(
                                      "Please Enter Mobile Number", context);
                                } else if (_emailController.text
                                    .length > 10 || _emailController.text
                                    .length < 10) {
                                  showCustomSnackBar(
                                      "Mobile Number Length Should be 10 Digits", context);
                                } else {
                                  var request = ForgetPasswordRequest();
                                  request.email = _emailController.text;
                                  BlocProvider.of<ForgetPasswordBloc>(context)
                                      .add(
                                    GetForgetPasswordEvent(
                                        forgetPasswordRequest: request),
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
}
