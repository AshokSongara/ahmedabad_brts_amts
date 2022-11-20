import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/source_destination_widget.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
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
  List<QuickLinkInternalModel> quickLinkList=[];
  @override
  void initState() {
    super.initState();
    quickLinkList.add(QuickLinkInternalModel("M Ticket", ImageConstant.iTicket));
    quickLinkList.add(QuickLinkInternalModel("Smart Recharge", ImageConstant.iMobileRed));
    quickLinkList.add(QuickLinkInternalModel("Stops", ImageConstant.iRoute));
    quickLinkList.add(QuickLinkInternalModel("My Routes", ImageConstant.iRate));
    quickLinkList.add(QuickLinkInternalModel("Transit Map", ImageConstant.iMap));
    quickLinkList.add(QuickLinkInternalModel("Feedback", ImageConstant.iChat));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBackground,
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
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
                        BoxShadow(
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.dp50))),
                          child: Center(
                            child: Text(
                              "AMTS",
                              style: satoshiRegular.copyWith(
                                  fontSize: 12,
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.dp50))),
                          child: Center(
                            child: Text(
                              "BRTS",
                              style: satoshiRegular.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: selectedValue == 1
                                      ? Colors.white
                                      : AppColors.darkGray),
                            ),
                          )),
                    ]),
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(right: Dimensions.dp20),
                    child: SvgPicture.asset(ImageConstant.iMenu))
              ],
            ),
            SizedBox(
              height: Dimensions.dp20,
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.dp20, right: Dimensions.dp30),
              child: Text(
                "Plan Your Trip",
                style: satoshiRegular.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGray),
              ),
            ),
            SizedBox(
              height: Dimensions.dp15,
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.dp20, right: Dimensions.dp30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray6E8EE7,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.dp16),),),
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
                          SourceDestinationWidget(
                              title: "From",
                              content: "Ahmedabad Municipal Transport Service",
                              contentTitle: "Adalaj Gam",
                              svgImageFile: ImageConstant.iFromBus),

                          // SizedBox(height: 22,),
                          Align(
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
                                decoration: BoxDecoration(
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
                      padding: EdgeInsets.only(top: Dimensions.dp20),
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
                                      side: BorderSide(
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
                                                SizedBox(
                                                  width: Dimensions.dp14,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "15/07/2022",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize:
                                                                Dimensions.dp16,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.dp10),
                                        child: Text(
                                          "Departure",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: Dimensions.dp14),
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
                                    side: BorderSide(
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
                                              SizedBox(
                                                width: Dimensions.dp14,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "09:10 AM",
                                                  style:
                                                      satoshiRegular.copyWith(
                                                          fontSize:
                                                              Dimensions.dp16,
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.dp10),
                                      child: Text(
                                        "Time",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: Dimensions.dp14),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: Dimensions.dp10, right: Dimensions.dp10, top: Dimensions.dp15),
                      child: CustomButton(
                        text: "Show Route & Fare",
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Get.toNamed(RouteHelper.getSearchResultRoute());
                        },
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        height: Dimensions.dp53,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.dp18,
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.dp20, right: Dimensions.dp30),
              child: Text(
                "Quick Links",
                style: satoshiRegular.copyWith(
                    fontSize: Dimensions.dp20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGray),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Dimensions.dp20, right: Dimensions.dp30,top:Dimensions.dp16),
              decoration: BoxDecoration(
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
                padding: EdgeInsets.all(Dimensions.dp20),
                child: GridView.builder(
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: quickLinkList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: Dimensions.dp10,
                    mainAxisSpacing: 10
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return getGridItemWidget(quickLinkList[index]);
                  },
                ),
              ),
            ),
            SizedBox(height: Dimensions.dp40,)
          ],
        ));
  }
  Widget getGridItemWidget(QuickLinkInternalModel model){
    return Column(
      children: [
        SvgPicture.asset(
          model.imagePath,
          height: Dimensions.dp35,
          width: Dimensions.dp35,
        ),
        SizedBox(
          height: Dimensions.dp4,
        ),
        Text(
          model.title,
          textAlign: TextAlign.center,
          style: satoshiRegular.copyWith(
              fontSize: Dimensions.dp14,
              fontWeight: FontWeight.w500,
              color: AppColors.darkGray),
        )
      ],
    );
  }
}
