import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/source_destination_widget.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../data/responseModels/quick_link_internal_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedValue = 0;
  List<QuickLinkInternalModel> quickLinkList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    quickLinkList
        .add(QuickLinkInternalModel("M Ticket", ImageConstant.iTicket));
    quickLinkList.add(
        QuickLinkInternalModel("Smart Recharge", ImageConstant.iMobileRed));
    quickLinkList.add(QuickLinkInternalModel("Stops", ImageConstant.iRoute));
    quickLinkList.add(QuickLinkInternalModel("My Routes", ImageConstant.iRate));
    quickLinkList
        .add(QuickLinkInternalModel("Transit Map", ImageConstant.iMap));
    quickLinkList.add(QuickLinkInternalModel("Feedback", ImageConstant.iChat));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.appBackground,
        endDrawer: Drawer(
          backgroundColor: AppColors.primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(
                top: Dimensions.dp24,
                left: Dimensions.dp43,
                right: Dimensions.dp43),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(ImageConstant.iClose)),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.dp35),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: Dimensions.dp22,
                          backgroundColor: AppColors.profileBackgroundGrey,
                          child: ClipOval(
                            child: Image.asset(
                              ImageConstant.iAvatar,
                              height: Dimensions.dp41,
                              width: Dimensions.dp38,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: Dimensions.dp14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "John Doe",
                              style: satoshiRegular.copyWith(
                                  fontSize: Dimensions.dp19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              "View Profile",
                              style: satoshiRegular.copyWith(
                                  fontSize: Dimensions.dp12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.dp28,
                  ),
                  const Divider(
                    thickness: Dimensions.dp2,
                    color: AppColors.gray6E8EE7,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iTicket,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      "M Ticket",
                      style: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iRoute,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      "Stops",
                      style: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getNearByRoute());
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iRate,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      "My Routes",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iMap,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      "Transit Map",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iTransactionHistory,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      "Transaction History",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iChat,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      "Feedback",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getFeedbackRoute());
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iSpeaker,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      "Invite Friends",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iCall,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      "Contact Us",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iSignOut,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      "Signout",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.dp50,
                  )
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: Dimensions.dp10,
            ),
            Row(
              children: [
                Container(
                  height: Dimensions.dp40,
                  width: Dimensions.dp140,
                  margin: const EdgeInsets.only(
                      left: Dimensions.dp20, right: Dimensions.dp30),
                  decoration: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(
                          color: AppColors.gray6E8EE7,
                          blurRadius: 5.0,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimensions.dp50))),
                  child: Container(
                    margin: const EdgeInsets.all(3.0),
                    child: Row(children: [
                      Container(
                          height: Dimensions.dp40,
                          width: Dimensions.dp65,
                          decoration: BoxDecoration(
                              color: selectedValue == 0
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(Dimensions.dp50))),
                          child: Center(
                            child: Text(
                              "AMTS",
                              style: satoshiRegular.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: selectedValue == 0
                                      ? Colors.white
                                      : AppColors.darkGray),
                            ),
                          )),
                      Container(
                          height: Dimensions.dp40,
                          width: Dimensions.dp65,
                          decoration: BoxDecoration(
                              color: selectedValue == 1
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(Dimensions.dp50))),
                          child: Center(
                            child: Text(
                              "BRTS",
                              style: satoshiRegular.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: selectedValue == 1
                                      ? Colors.white
                                      : AppColors.darkGray),
                            ),
                          )),
                    ]),
                  ),
                ),
                const Spacer(),
                Container(
                    margin: const EdgeInsets.only(right: Dimensions.dp20),
                    child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: SvgPicture.asset(ImageConstant.iMenu)))
              ],
            ),
            const SizedBox(
              height: Dimensions.dp20,
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.dp20, right: Dimensions.dp30),
              child: Text(
                "Plan Your Trip",
                style: satoshiRegular.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGray),
              ),
            ),
            const SizedBox(
              height: Dimensions.dp15,
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.dp20, right: Dimensions.dp30),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray6E8EE7,
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.dp16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.dp10, vertical: Dimensions.dp19),
                child: Column(
                  children: [
                    SizedBox(
                      height: 170,
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          const SourceDestinationWidget(
                              title: "From",
                              content: "Ahmedabad Municipal Transport Service",
                              contentTitle: "Adalaj Gam",
                              svgImageFile: ImageConstant.iFromBus),

                          // SizedBox(height: 22,),
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: SourceDestinationWidget(
                                title: "To",
                                content:
                                    "Ahmedabad Municipal Transport Service",
                                contentTitle: "Ahmedabad Airport",
                                svgImageFile: ImageConstant.iToBus),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 48,
                                height: 48,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      ImageConstant.iArrowDownUp),
                                ),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.fromBorderSide(BorderSide(
                                      color: AppColors.gray6E8EE7,
                                      width: 1,
                                    )),
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.dp20),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.dp10), // if you need this
                                      side: const BorderSide(
                                        color: AppColors.gray6E8EE7,
                                        width: 1,
                                      ),
                                    ),
                                    color: Colors.transparent,
                                    elevation: 0,
                                    child: SizedBox(
                                      height: Dimensions.dp55,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: Dimensions.dp18,
                                            top: Dimensions.dp13,
                                            bottom: Dimensions.dp13),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                    ImageConstant.iCalendar),
                                                const SizedBox(
                                                  width: Dimensions.dp14,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "15/07/2022",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AppColors
                                                                .darkGray),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: Dimensions.dp14,
                                      top: -3,
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: Dimensions.dp10),
                                        child: Text(
                                          "Departure",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp),
                                        ),
                                      )),
                                ],
                              )),
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.dp10), // if you need this
                                    side: const BorderSide(
                                      color: AppColors.gray6E8EE7,
                                      width: Dimensions.dp1,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: SizedBox(
                                    height: Dimensions.dp55,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: Dimensions.dp18,
                                          top: Dimensions.dp13,
                                          bottom: Dimensions.dp13),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                  ImageConstant.iTime),
                                              const SizedBox(
                                                width: Dimensions.dp14,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "09:10 AM",
                                                  style:
                                                      satoshiRegular.copyWith(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: AppColors
                                                              .darkGray),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: Dimensions.dp14,
                                    top: -3,
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: Dimensions.dp10),
                                      child: Text(
                                        "Time",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: Dimensions.dp10,
                          right: Dimensions.dp10,
                          top: Dimensions.dp15),
                      child: CustomButton(
                        text: "Show Route & Fare",
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Get.toNamed(RouteHelper.getSearchResultRoute());
                        },
                        style: satoshiRegular.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        height: Dimensions.dp53,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.dp18,
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.dp20, right: Dimensions.dp30),
              child: Text(
                "Quick Links",
                style: satoshiRegular.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGray),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.dp20,
                  right: Dimensions.dp30,
                  top: Dimensions.dp16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray6E8EE7,
                      blurRadius: Dimensions.dp5,
                    ),
                  ],
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.dp16))),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(Dimensions.dp20),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: quickLinkList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: Dimensions.dp10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return getGridItemWidget(quickLinkList[index]);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.dp40,
            )
          ],
        ));
  }

  Widget getGridItemWidget(QuickLinkInternalModel model) {
    return GestureDetector(
      onTap: () {
        if (model.title == "Feedback") {
          Get.toNamed(RouteHelper.getFeedbackRoute());
        } else if (model.title == "My Routes") {
          Get.toNamed(RouteHelper.getMyRouteScreen());
        } else if (model.title == "Stops") {
          Get.toNamed(RouteHelper.getNearByRoute());
        }
      },
      child: Column(
        children: [
          SvgPicture.asset(
            model.imagePath,
            height: Dimensions.dp35,
            width: Dimensions.dp35,
          ),
          const SizedBox(
            height: Dimensions.dp4,
          ),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: satoshiRegular.copyWith(
                fontSize: Dimensions.dp14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray),
          )
        ],
      ),
    );
  }
}
