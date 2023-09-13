import 'dart:async';
import 'dart:convert';

import 'package:ahmedabad_brts_amts/data/requestmodels/signup_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_state.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/signup_otp_verification_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_text_field.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/password_text_field.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/loader/overylay_loader.dart';

class SignupScreen extends StatefulWidget {
  final String? type;

  const SignupScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  int _selectedGender = 1;
  String? number;







  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (BuildContext context, state) {
          if (state is SignupInitialState) {
          } else if (state is SignupLoadingState) {
            Loader.show(context);
          } else if (state is SignupSuccessState) {
            print("####Signup Response${state.signUpResponse}");

            Loader.hide();
            showCustomSnackBar("Signup Successfull...!", context,
                isError: false);
            Get.offNamed(RouteHelper.login);
          } else if (state is SignupFailedState) {
            Loader.hide();
            showCustomSnackBar(state.errorMessage, context, isError: false);
          } else {
            Loader.hide();
            showCustomSnackBar("Something Went Wrong Try again..!", context,
                isError: false);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(children: [
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
              Container(
                margin: const EdgeInsets.only(left: Dimensions.dp25),
                child: Row(children: [
                  GestureDetector(child: SvgPicture.asset(ImageConstant.iLeftArrow),onTap: (){
                    {
                      if (widget.type == "profile") {
                        SystemNavigator.pop();
                      } else {
                        Get.back();
                      }
                    }
                  }),
                  Text(
                    "Sign Up",
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
                      "First Name",
                      style: satoshiRegular.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray),
                    ),
                    CustomTextField(
                      textStyle:
                          satoshiRegular.copyWith(color: AppColors.darkGray),
                      controller: _nameController,
                      focusNode: _nameFocus,
                      nextFocus: _lastNameFocus,
                      inputType: TextInputType.name,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "abc",
                    ),
                    const SizedBox(
                      height: Dimensions.dp20,
                    ),
                    Text(
                      "Last Name",
                      style: satoshiRegular.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray),
                    ),
                    CustomTextField(
                      textStyle:
                          satoshiRegular.copyWith(color: AppColors.darkGray),
                      controller: _lastNameController,
                      focusNode: _lastNameFocus,
                      nextFocus: _emailFocus,
                      textLength: 10,
                      inputType: TextInputType.emailAddress,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "xyz",
                    ),
                    const SizedBox(
                      height: Dimensions.dp20,
                    ),
                    Text(
                      "Email",
                      style: satoshiRegular.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray),
                    ),
                    CustomTextField(
                      textStyle:
                          satoshiRegular.copyWith(color: AppColors.darkGray),
                      controller: _emailController,
                      focusNode: _emailFocus,
                      nextFocus: _mobileFocus,
                      inputType: TextInputType.emailAddress,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "abcxyz@gmail.com",
                    ),
                    const SizedBox(
                      height: Dimensions.dp20,
                    ),
                    Text(
                      "Mobile Number",
                      style: satoshiRegular.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray),
                    ),
                    CustomTextField(
                      textStyle:
                          satoshiRegular.copyWith(color: AppColors.darkGray),
                      controller: _mobileNumberController,
                      focusNode: _mobileFocus,
                      nextFocus: _passwordFocus,
                      inputType: TextInputType.phone,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "99******99",
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
                      textStyle:
                          satoshiRegular.copyWith(color: AppColors.darkGray),
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      nextFocus: _confirmPasswordFocus,
                      inputType: TextInputType.text,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "******",
                    ),
                    const SizedBox(
                      height: Dimensions.dp20,
                    ),
                    Text(
                      "Confirm Password",
                      style: satoshiRegular.copyWith(
                          fontSize: 15.sp,
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
                      inputType: TextInputType.text,
                      onChanged: () {},
                      onSubmit: () {},
                      capitalization: TextCapitalization.words,
                      divider: false,
                      hintText: "******",
                    ),
                    const SizedBox(
                      height: Dimensions.dp20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Gender",
                          style: satoshiRegular.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGray),
                        ),
                        const SizedBox(
                          width: Dimensions.dp15,
                        ),
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.red,),
                              child: Radio<int>(
                                activeColor: AppColors.lightBlue,
                                value: 1,
                                groupValue: _selectedGender,
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedGender = value ?? 1;
                                  });
                                },
                              ),
                            ),
                            Text('Male', style: satoshiRegular.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkGray),),
                          ],
                        ),
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.red,),
                              child: Radio<int>(
                                activeColor: AppColors.lightBlue,
                                value: 2,
                                groupValue: _selectedGender,
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedGender = value ?? 1;
                                  });
                                },
                              ),
                            ),
                            Text('Female', style: satoshiRegular.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkGray),),
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.dp100,
                    ),

                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 30, right: 30, bottom: Dimensions.dp10),
                  child: CustomButton(
                    color: Theme.of(context).primaryColor,
                    text: "Sign Up",
                    width: MediaQuery.of(context).size.width,
                    onPressed: ()async {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                      print(_selectedGender);

                      if (FocusManager.instance.primaryFocus!.hasFocus) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                      // Get.toNamed(RouteHelper.getMobileNumberRoute());
                      if (_nameController.text.toString().trim().isEmpty) {
                        showCustomSnackBar("Please Enter Name", context);
                      } else if (_lastNameController.text
                          .trim()
                          .toString()
                          .isEmpty) {
                        showCustomSnackBar("Please LastName", context);
                      } else if (_emailController.text
                          .trim()
                          .toString()
                          .isEmpty) {
                        showCustomSnackBar("Please Enter EmailID", context);
                      } else if (!_emailController.text.isValidEmail()) {
                        showCustomSnackBar(
                            "Please Enter Valid EmailID", context);
                      } else if (_mobileNumberController.text
                          .trim()
                          .toString()
                          .isEmpty) {
                        showCustomSnackBar(
                            "Please enter Mobile number", context);
                      } else if (_mobileNumberController.text.length > 10) {
                        showCustomSnackBar(
                            "Mobile Number should be 10 Digits", context);
                      } else if (_mobileNumberController.text.length < 10) {
                        showCustomSnackBar(
                            "Mobile Number should be 10 Digits", context);
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
                      } else if (_confirmPasswordController.text
                          .toString()
                          .isEmpty) {
                        showCustomSnackBar(
                            "Please Enter Confirm Password", context);
                      } else if (_passwordController.text.toString() !=
                          _confirmPasswordController.text.toString()) {
                        showCustomSnackBar(
                            "Password and Confirm Password Not Matched",
                            context);
                      } else {
                        fetchOtpResponse(_mobileNumberController.text);
                        bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpOtpVerification(mobileNumber: _mobileNumberController.text,)));
                        if (result == true) {
                          var request = SignupRequest();
                          request.name = _nameController.text;
                          request.lastname = _lastNameController.text;
                          request.email = _emailController.text;
                          request.password = _passwordController.text;
                          request.phoneNumber = _mobileNumberController.text;
                          request.gender = _selectedGender;

                          BlocProvider.of<SignupBloc>(context).add(
                            SignupUserEvent(data: request),
                          );
                        } else {
                          // Handle other cases
                        }

                        // var request = SignupRequest();
                        // request.name = _nameController.text;
                        // request.lastname = _lastNameController.text;
                        // request.email = _emailController.text;
                        // request.password = _passwordController.text;
                        // request.phoneNumber = _mobileNumberController.text;
                        // request.gender = _selectedGender;
                        //
                        // BlocProvider.of<SignupBloc>(context).add(
                        //   SignupUserEvent(data: request),
                        // );
                      }
                    },
                    style: poppinsMedium.copyWith(
                        color: Colors.white, fontSize: 15.sp),
                    height: 53,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
            ]),
          );
        },
      ),
    );
  }



  Future<MobileNumberOtpResponseEntity> fetchOtpResponse(String no) async {

    final String apiUrl = "https://www.transportapp.co.in:8081/User/otp/generateOTP";
    final Map<String, dynamic> data = {
      'phoneNumber': no,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return MobileNumberOtpResponseEntity.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }





  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }
}
