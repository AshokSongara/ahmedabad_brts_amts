import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/contactus/contact_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/contactus/contact_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/contactus/contact_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    BlocProvider.of<ContactBloc>(context).add(GetContactEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoadingState) {
            Loader.show(context);
          } else if (state is ContactSuccessState) {
            Loader.hide();
            return Column(
              children: [
                SizedBox(height: Dimensions.dp25),
                CustomToolbar(
                  title: "contact_us",
                  showOption: false,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.dp19, vertical: Dimensions.dp26),
                  margin: const EdgeInsets.only(
                      left: Dimensions.dp24,
                      right: Dimensions.dp24,
                      top: Dimensions.dp10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray6E8EE7,
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.dp10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Hello Amit Yogi",
                        textAlign: TextAlign.center,
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: Dimensions.dp25.h,
                      ),
                      Text(
                        "How can we help you?",
                        textAlign: TextAlign.center,
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGray),
                      ),
                      SizedBox(
                        height: Dimensions.dp26.h,
                      ),
                      Container(
                        height: 53,
                        child: CustomButton(
                          color: Theme.of(context).primaryColor,
                          text: "Email Us",
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: state.contactUsResponse.data?.email ?? "",
                            );
                            launchUrlString(emailLaunchUri.toString());
                          },
                          style: poppinsMedium.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18),
                          height: 53,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.dp26.h,
                      ),
                      Text(
                        "OR",
                        textAlign: TextAlign.center,
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkGray),
                      ),
                      SizedBox(
                        height: Dimensions.dp26.h,
                      ),
                      Container(
                        height: 53,
                        child: CustomButton(
                          color: Theme.of(context).primaryColor,
                          text: "Call Us",
                          width: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            launchPhoneDialer(state.contactUsResponse.data?.mobile ?? "");
                          },
                          style: poppinsMedium.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18),
                          height: 53,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.dp14.h,
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
