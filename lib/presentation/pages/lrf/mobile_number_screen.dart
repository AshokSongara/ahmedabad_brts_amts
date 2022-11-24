import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/numeric_keyboard.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/loader/overylay_loader.dart';

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
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
          BlocConsumer<MobileNumberLoginBloc, MobileNumberLoginState>(
              listener: (BuildContext context, state) {
            if (state is MobileNumberLoginSuccessState) {
              Loader.hide();
              Get.toNamed(RouteHelper.getEnterCodeRoute());
            } else if (state is MobileNumberLoginErrorState) {
              Loader.hide();
              debugPrint("Api Call Error");
            } else if (state is MobileNumberLoadingState) {
              Loader.show(context);
            } else if (state is MobileNumberValidationErrorState) {
              Loader.hide();
               debugPrint("Validation Error");
            }
          }, builder: (context, state) {
            return Column(
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
                    maxLength: 10,
                    cursorColor: Colors.white,
                    autofocus: true,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
                      counterText: "",
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
            );
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(
                  left: 30, right: 30, bottom: Dimensions.dp10),
              child: CustomButton(
                text: "PEOCEED",
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                  BlocProvider.of<MobileNumberLoginBloc>(context)
                      .add(PhoneNumberSubmitEvent(_mobileController.text));
                },
                style:
                    poppinsMedium.copyWith(color: Colors.white, fontSize: 15),
                height: 53,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onKeyboardTap(String value) {
    if (_mobileController.text.length < 10) {
      setState(() {
        _mobileController.text = _mobileController.text + value;
      });
    }
  }
}
