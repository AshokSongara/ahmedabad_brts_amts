import 'dart:async';

import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/otp_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/verify_otp/verify_otp_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/verify_otp/verify_otp_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/verify_otp/verify_otp_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/numeric_keyboard.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key,required this.mobileNumber}) : super(key: key);

  final String? mobileNumber;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  late Timer _timer;
  int _seconds = 0;
  String _timerText = "";
  String currentText = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
    _timer.cancel();
  }

  void _startTimer() {
    _seconds = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if (_seconds == 0) {
        timer.cancel();
        _timer.cancel();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
        listener: (BuildContext context, state) {
          if (state is VerifyOtpInitialState) {
          } else if (state is VerifyOtpLoadingState) {
            Loader.show(context);
          } else if (state is VerifyOtpSuccessState) {
            Loader.hide();
            saveMemberID(state.verifyOtpResponse.data?.jwt?.accessToken,
                state.verifyOtpResponse.data?.jwt?.email);
          } else {
            Loader.hide();
            showCustomSnackBar("Something Went Wrong Try again..!", context,
                isError: false);
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(
                height: Dimensions.dp30,
              ),
              Text(
                "Enter code sent to your phone",
                style: satoshiRegular.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkGray),
              ),
              const SizedBox(
                height: Dimensions.dp5,
              ),
              Text(
                "We sent it to the number +91 8734 99**",
                style: satoshiRegular.copyWith(
                    fontSize: 14.sp, color: AppColors.gray555555),
              ),
              const SizedBox(
                height: Dimensions.dp30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                    left: Dimensions.dp56, right: Dimensions.dp56),
                child: PinCodeTextField(
                  keyboardType: TextInputType.none,
                  appContext: context,
                  pastedTextStyle: satoshiRegular.copyWith(
                      color: AppColors.darkGray, fontSize: 24.sp),
                  length: 4,
                  animationType: AnimationType.fade,
                  validator: (v) {},
                  textStyle: satoshiRegular.copyWith(
                      color: AppColors.darkGray, fontSize: 24.sp),
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: Dimensions.dp50,
                      fieldWidth: Dimensions.dp50,
                      activeColor: AppColors.primaryColor,
                      inactiveColor: AppColors.lightGray,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: AppColors.primaryColor),
                  cursorColor: Colors.white,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    return true;
                  },
                ),
              ),
              NumericKeyboard(
                onKeyboardTap: _onKeyboardTap,
                textColor: AppColors.darkGray,
                rightButtonFn: () {
                  setState(() {
                    textEditingController.text = textEditingController.text
                        .substring(0, textEditingController.text.length - 1);
                  });
                },
                rightIcon: const Icon(
                  Icons.backspace,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: Dimensions.dp60,
              ),
              RichText(
                text: TextSpan(
                  text: "Don’t have an account?",
                  style: satoshiRegular.copyWith(
                      fontSize: 12.sp, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: " ",
                        style: satoshiRegular.copyWith(
                            fontSize: 12, color: Colors.black)),
                    TextSpan(
                        text: "00:47",
                        style: satoshiRegular.copyWith(
                            color: AppColors.primaryColor, fontSize: 12.sp)),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 30, right: 30, bottom: Dimensions.dp10),
                    child: CustomButton(
                      text: "NEXT",
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        if (textEditingController.text.toString().isEmpty) {
                          showCustomSnackBar("Please Enter OTP", context);
                        } else {
                          var request = OtpRequest();
                          request.phoneNumber = widget.mobileNumber;
                          request.otp = textEditingController.text;
                          BlocProvider.of<VerifyOtpBloc>(context).add(
                            PostVerifyOtpEvent(otpRequest: request),
                          );
                        }
                      },
                      style: poppinsMedium.copyWith(
                          color: Colors.white, fontSize: 15.sp),
                      height: 53,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      textEditingController.text = textEditingController.text + value;
    });
  }

  saveMemberID(String? token, String? email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.accessToken, token ?? "");
    prefs.setString(AppConstant.email, email ?? "");
    Get.toNamed(RouteHelper.dashboard);
  }
}
