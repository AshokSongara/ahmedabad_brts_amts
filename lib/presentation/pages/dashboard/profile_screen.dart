import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_text_field.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/password_text_field.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final String? from;

  const ProfileScreen({Key? key, required this.from}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String token = "";
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    getMemberID();
  }

  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(AppConstant.accessToken) ?? "";
    if (token.isNotEmpty) {
      getData();
    }
  }

  getData() {
    BlocProvider.of<UserProfileBloc>(context).add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoadingState) {
            Loader.show(context);
          } else if (state is UserProfileSuccessState) {
            Loader.hide();
            _nameController.text =
                state.userProfileResponse.data?.firstName ?? "";
            _emailController.text = state.userProfileResponse.data?.email ?? "";
            return Column(
              children: [
                const SizedBox(height: Dimensions.dp25),
                CustomToolbar(
                  title: "profile",
                  showOption: false,
                  back: widget.from == "home" ? true : false,
                ),
                const SizedBox(height: Dimensions.dp25),
                CircleAvatar(
                  radius: Dimensions.dp22,
                  backgroundColor: AppColors.profileBackgroundGrey,
                  child: ClipOval(
                    child: Image.asset(
                      ImageConstant.iAvatar,
                      height: Dimensions.dp50,
                      width: Dimensions.dp50,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Dimensions.dp10,
                ),
                Text(
                  state.userProfileResponse.data?.firstName ?? "",
                  style: satoshiRegular.copyWith(
                      fontSize: Dimensions.dp19,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGray),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: Dimensions.dp50,
                      left: Dimensions.dp35,
                      right: Dimensions.dp35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
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
                        nextFocus: _emailFocus,
                        inputType: TextInputType.name,
                        onChanged: () {},
                        onSubmit: () {},
                        capitalization: TextCapitalization.words,
                        divider: false,
                        hintText: "Kapil",
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
                        nextFocus: _passwordFocus,
                        inputType: TextInputType.name,
                        onChanged: () {},
                        onSubmit: () {},
                        capitalization: TextCapitalization.words,
                        divider: false,
                        hintText: "kapil@gmail.com",
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
                        nextFocus: _passwordFocus,
                        inputType: TextInputType.name,
                        onChanged: () {},
                        onSubmit: () {},
                        capitalization: TextCapitalization.words,
                        divider: false,
                        hintText: "******",
                      ),
                      const SizedBox(
                        height: Dimensions.dp100,
                      ),
                      CustomButton(
                        color: Theme.of(context).primaryColor,
                        text: "Save",
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {},
                        style: poppinsMedium.copyWith(
                            color: Colors.white, fontSize: 15.sp),
                        height: 53,
                      ),
                      // const SizedBox(
                      //   height: Dimensions.dp20,
                      // ),
                      // CustomButton(
                      //   color: AppColors.appBackground,
                      //   text: "Cancel",
                      //   width: MediaQuery.of(context).size.width,
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      //   style: poppinsMedium.copyWith(
                      //       color: Theme.of(context).primaryColor, fontSize: 15.sp),
                      //   height: 53,
                      // ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Container(
              height: 53,
              margin: EdgeInsets.all(50),
              child: CustomButton(
                color: Theme.of(context).primaryColor,
                text: AppLocalizations.of(context)?.translate("go_to_login") ?? "",
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                  Get.offNamed(RouteHelper.login);
                },
                style: poppinsMedium.copyWith(
                    color: Colors.white, fontSize: 15.sp),
                height: 53,
              ),
            ),
          );
        },
      ),
    );
  }
}
