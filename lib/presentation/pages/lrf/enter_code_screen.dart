import 'dart:async';

import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/numeric_keyboard.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({Key? key}) : super(key: key);

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
      resizeToAvoidBottomInset : false,
      body: Column(
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
          SizedBox(
            height: Dimensions.dp30,
          ),
          Text(
            "Enter code sent to your phone",
            style: satoshiRegular.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray),
          ),
          SizedBox(
            height: Dimensions.dp5,
          ),
          Text(
            "We sent it to the number +91 8734 99**",
            style: satoshiRegular.copyWith(
                fontSize: 14, color: AppColors.gray555555),
          ),
          SizedBox(
            height: Dimensions.dp30,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin:
                EdgeInsets.only(left: Dimensions.dp56, right: Dimensions.dp56),
            child: PinCodeTextField(
              keyboardType: TextInputType.none,
              appContext: context,
              pastedTextStyle: satoshiRegular.copyWith(
                  color: AppColors.darkGray, fontSize: 24),
              length: 4,
              animationType: AnimationType.fade,
              validator: (v) {},
              textStyle: satoshiRegular.copyWith(
                  color: AppColors.darkGray, fontSize: 24),
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
            rightIcon: Icon(
              Icons.backspace,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: Dimensions.dp60,),
          RichText(
            text: TextSpan(
              text: "Don’t have an account?",
              style: satoshiRegular.copyWith(fontSize: 12, color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: " ",
                    style: satoshiRegular.copyWith(
                        fontSize: 12, color: Colors.black)),
                TextSpan(
                    text: "00:47",
                    style: satoshiRegular.copyWith(
                        color: AppColors.primaryColor, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30,bottom: Dimensions.dp10),
                child: CustomButton(
                  text: "NEXT",
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    Get.toNamed(RouteHelper.getDashboardRoute());
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

  _onKeyboardTap(String value) {
    setState(() {
      textEditingController.text = textEditingController.text + value;
    });
  }
}
