import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/login_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/signup_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/logic_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_state.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool passenable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (BuildContext context, state) {
            if (state is LoginInitialState) {
            } else if (state is LoginLoadingState) {
              Loader.show(context);
            } else if (state is LoginSuccessState) {
              Loader.hide();
              Get.toNamed(RouteHelper.dashboard);
            } else {
              Loader.hide();
              showCustomSnackBar("Something Went Wrong Try again..!", context,
                  isError: false);
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
                          "Login",
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
                            "Email",
                            style: satoshiRegular.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkGray),
                          ),
                          CustomTextField(
                            textStyle: satoshiRegular.copyWith(
                                color: AppColors.darkGray),
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
                            hintText: "******",
                          ),
                          SizedBox(
                            height: Dimensions.dp75,
                          ),
                          Container(
                            height: 53,
                            child: CustomButton(
                              text: "Login",
                              width: MediaQuery.of(context).size.width,
                              onPressed: () {
                                if (_emailController.text.toString().isEmpty) {
                                  showCustomSnackBar(
                                      "Please Enter EmailID", context);
                                } else if (!_emailController.text
                                    .isValidEmail()) {
                                  showCustomSnackBar(
                                      "Please Enter Valid EmailID", context);
                                } else if (_passwordController.text
                                    .toString()
                                    .isEmpty) {
                                  showCustomSnackBar(
                                      "Please Enter Password", context);
                                } else {
                                  var request = LoginRequest();
                                  request.email = _emailController.text;
                                  request.password = _passwordController.text;
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LoginUserEvent(loginRequest: request),
                                  );
                                }
                              },
                              style: poppinsMedium.copyWith(
                                  color: Colors.white, fontSize: 15),
                              height: 53,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.dp25,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Forgot Your Password?",
                                style: satoshiRegular.copyWith(
                                    fontSize: 14, color: AppColors.darkGray),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " ",
                                      style: satoshiRegular.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                  TextSpan(
                                      text: "Click Here",
                                      style: satoshiRegular.copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.dp20,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don’t have an account?",
                                style: satoshiRegular.copyWith(
                                    fontSize: 14, color: AppColors.darkGray),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " ",
                                      style: satoshiRegular.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                  TextSpan(
                                      text: "Sign Up",
                                      style: satoshiRegular.copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
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
