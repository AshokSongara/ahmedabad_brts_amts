import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/numeric_keyboard.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/base/custom_snackbar.dart';
import '../../../core/loader/overylay_loader.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({Key? key}) : super(key: key);

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final _mobileController = TextEditingController();
  final FocusNode _mobileFocus = FocusNode();
  late String _mobile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _mobileController.dispose();
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
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
              height: Dimensions.dp30,
            ),
            BlocConsumer<MobileNumberLoginBloc, MobileNumberLoginState>(
                listener: (BuildContext context, state) {
                  if (state is MobileNumberLoginSuccessState) {
                    Loader.hide();
                    Get.toNamed(RouteHelper.getEnterCodeRoute(
                        _mobileController.text.toString()));
                  } else if (state is MobileNumberLoginErrorState) {
                    Loader.hide();
                    showCustomSnackBar("User Not Registred", context,
                        isError: true);
                    Get.toNamed(RouteHelper.signup);
                    debugPrint("Api Call Error");
                  } else if (state is MobileNumberLoadingState) {
                    Loader.show(context);
                  } else if (state is MobileNumberValidationErrorState) {
                    Loader.hide();
                    showCustomSnackBar(
                        "Please enter valid Mobile number", context,
                        isError: true);
                    debugPrint("Validation Error");
                    showCustomSnackBar(
                        "Please enter valid Mobile number", context,
                        isError: true);
                  } else if (state is MobileNumberLoginErrorState) {
                    Loader.hide();
                    showCustomSnackBar("User Not Registred", context,
                        isError: true);
                  }
                }, builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to AMTS - BRTS",
                    style: satoshiRegular.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGray),
                  ),
                  Text(
                    "We will send an OTP on this mobile number.",
                    style: satoshiRegular.copyWith(
                        fontSize: 14.sp, color: AppColors.gray555555),
                  ),
                  const SizedBox(
                    height: Dimensions.dp20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: Theme.of(context).primaryColor),
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
                      style: TextStyle(
                        fontSize: 17.0.sp,
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
                        hintStyle: satoshiRegular.copyWith(
                            color: AppColors.grayC4C$C$),
                        contentPadding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
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
                  const SizedBox(
                    height: Dimensions.dp30,
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: AppColors.darkGray,
                    rightButtonFn: () {
                      onBackspacePressed();
                      // setState(() {
                      //   _mobileController.text = _mobileController.text
                      //       .substring(0, _mobileController.text.length - 1);
                      // });
                    },
                    rightIcon: Icon(
                      Icons.backspace,
                      color: Theme.of(context).primaryColor,
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
                  color: Theme.of(context).primaryColor,
                  text: "PROCEED",
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if(_mobileController.text.length != 10){
                      showCustomSnackBar(
                          "Please enter a valid Mobile number",
                          context,
                          isError: true);
                    }
                    else {
                      BlocProvider.of<MobileNumberLoginBloc>(context)
                          .add(PhoneNumberSubmitEvent(_mobileController.text));
                    }
                  },
                  style: poppinsMedium.copyWith(
                      color: Colors.white, fontSize: 15.sp),
                  height: 53,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onBackspacePressed() {
    final text = _mobileController.text;
    final selection = _mobileController.selection;

    if (selection.start > 0) {
      final newSelection = selection.copyWith(
        baseOffset: selection.start - 1,
        extentOffset: selection.start - 1,
      );

      final newText = text.substring(0, selection.start - 1) + text.substring(selection.end);

      setState(() {
        _mobileController.value = _mobileController.value.copyWith(
          text: newText,
          selection: newSelection,
        );
      });
    }
  }



  _onKeyboardTap(String value) {
    if (_mobileController.text.length < 10) {
      final text = _mobileController.text;
      final selection = _mobileController.selection;

      final newText = text.replaceRange(
        selection.start,
        selection.end,
        value,
      );

      final newSelection = TextSelection.collapsed(
        offset: selection.start + value.length,
      );

      setState(() {
        _mobileController.value = TextEditingValue(
          text: newText,
          selection: newSelection,
        );
      });
    }
  }
}
