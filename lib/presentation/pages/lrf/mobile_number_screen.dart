import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/numeric_keyboard.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({Key? key}) : super(key: key);

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final _mobileController = TextEditingController();
  final FocusNode _mobileFocus = FocusNode();
  String _mobile = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to AMTS - BRTS",
                style: satoshiRegular.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkGray),
              ),
              Text(
                "We will send an OTP on this mobile number.",
                style: satoshiRegular.copyWith(
                    fontSize: 14, color: AppColors.gray555555),
              ),
              SizedBox(
                height: Dimensions.dp20,
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: AppColors.primaryColor),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: TextFormField(
                  controller: _mobileController,
                  focusNode: _mobileFocus,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  cursorColor: Colors.white,
                  autofocus: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.none,
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixText: '+91 | ',
                    prefixStyle:
                        satoshiRegular.copyWith(color: AppColors.darkGray),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter Mobile Number",
                    hintStyle:
                        satoshiRegular.copyWith(color: AppColors.grayC4C$C$),
                    contentPadding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  validator: (mobile) {
                    if (mobile!.isEmpty) {
                      "Please Enter Mobile Number";
                    } else if (mobile.length < 10) {
                      return "Please Enter Valid Number";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (mobile) => _mobile = mobile!,
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                height: Dimensions.dp30,
              ),
              NumericKeyboard(
                onKeyboardTap: _onKeyboardTap,
                textColor: AppColors.darkGray,
                rightButtonFn: () {
                  setState(() {
                    _mobileController.text = _mobileController.text
                        .substring(0, _mobileController.text.length - 1);
                  });
                },
                rightIcon: Icon(
                  Icons.backspace,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30,bottom: Dimensions.dp10),
                child: CustomButton(
                  text: "PEOCEED",
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    Get.toNamed(RouteHelper.getEnterCodeRoute());
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
      _mobileController.text = _mobileController.text + value;
    });
  }
}
