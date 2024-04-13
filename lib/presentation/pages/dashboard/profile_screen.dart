import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/profile_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_text_field.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  //final String? from;

  const ProfileScreen({Key? key,
    //this.from
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();

  String token = "";
  String name = "";
  String email = "";
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _lastnameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    getMemberID();
  }

  getMemberID() {
    if (AppConstant.IsLoggedIn.isNotEmpty) {
      _emailController.text = AppConstant.emailData;
      _nameController.text = AppConstant.nameData;
      _lastnameController.text = AppConstant.lastNameData;
    }
  }

  getData() {
    var request = ProfileRequest();
    request.firstName = _nameController.text;
    request.lastName = _lastnameController.text;
    BlocProvider.of<UserProfileBloc>(context).add(
      GetUserProfileEvent(profileRequest: request),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.appBackground2,
        body: SafeArea(
          child: AppConstant.IsLoggedIn.isNotEmpty
              ? SingleChildScrollView(
                  child: BlocConsumer<UserProfileBloc, UserProfileState>(
                    listener: (context, state) {
                      if (state is UserProfileLoadingState) {
                        Loader.show(context);
                      } else if (state is UserProfileSuccessState) {
                        Loader.hide();
                      } else if (state is UserProfileFailedState) {
                        Loader.hide();
                      }
                    },
                    buildWhen: (previous, current) =>
                        previous != current &&
                        current is UserProfileSuccessState,
                    builder: (context, state) {
                      return Column(
                        children: [
                          // const SizedBox(height: Dimensions.dp25),
                          CustomToolbar(
                            title: "profile",
                            showOption: false,
                           // back: widget.from == "home" ? true : false,
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
                            name,
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
                                  "FirstName",
                                  style: satoshiRegular.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkGray),
                                ),
                                CustomTextField(
                                  textStyle: satoshiRegular.copyWith(
                                      color: AppColors.darkGray),
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  nextFocus: _emailFocus,
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
                                  "LastName",
                                  style: satoshiRegular.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkGray),
                                ),
                                CustomTextField(
                                  textStyle: satoshiRegular.copyWith(
                                      color: AppColors.darkGray),
                                  controller: _lastnameController,
                                  focusNode: _lastnameFocus,
                                  nextFocus: _emailFocus,
                                  inputType: TextInputType.name,
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
                                  isEnabled: false,
                                  textStyle: satoshiRegular.copyWith(
                                      color: AppColors.darkGray),
                                  controller: _emailController,
                                  focusNode: _emailFocus,
                                  nextFocus: _passwordFocus,
                                  inputType: TextInputType.name,
                                  onChanged: () {},
                                  onSubmit: () {},
                                  capitalization: TextCapitalization.words,
                                  divider: false,
                                  hintText: "abcxyz@gmail.com",
                                ),

                                const SizedBox(
                                  height: Dimensions.dp20,
                                ),
                                CustomButton(
                                  color: Theme.of(context).primaryColor,
                                  text: "Save",
                                  width: MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    if (_nameController.text
                                        .toString()
                                        .isEmpty) {
                                      showCustomSnackBar(
                                          "Please Enter FirstName", context);
                                    } else if (_lastnameController.text
                                        .toString()
                                        .isEmpty) {
                                      showCustomSnackBar(
                                          "Please Enter LastName", context);
                                    } else {
                                      getData();
                                    }
                                  },
                                  style: poppinsMedium.copyWith(
                                      color: Colors.white, fontSize: 15.sp),
                                  height: 53,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80.h,),
                      SizedBox(
                          height: 80.h,
                          child: Image.asset(ImageConstant.iCombineLogo)),
                      Container(
                        height: 53,
                        margin: const EdgeInsets.all(50),
                        child: CustomButton(
                          color: Theme.of(context).primaryColor,
                          text: AppLocalizations.of(context)
                                  ?.translate("go_to_login") ??
                              "",
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Get.offNamed(RouteHelper.splash);
                          },
                          style: poppinsMedium.copyWith(
                              color: Colors.white, fontSize: 15.sp),
                          height: 53,
                        ),
                      ),
                      Container(
                        height: 53,
                        margin: const EdgeInsets.all(50),
                        child: CustomButton(
                          color:Theme.of(context).primaryColor,
                          text: "SignUp",
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Get.offNamed(RouteHelper.getSignUpRoute("profile"));
                          },
                          style: poppinsMedium.copyWith(
                              color: Colors.white, fontSize: 15.sp),
                          height: 53,
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }
}
