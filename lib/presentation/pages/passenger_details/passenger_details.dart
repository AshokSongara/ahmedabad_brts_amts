import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PassengerDetails extends StatefulWidget {
  const PassengerDetails({Key? key}) : super(key: key);

  @override
  _PassengerDetailsState createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  int _addedAdultsCount = 0;
  int _addedKidsCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Column(
        children: [
          const SizedBox(height: Dimensions.dp25),
          CustomToolbar(
            title: "passenger_details",
            showOption: false,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 24),
            margin: const EdgeInsets.only(
                left: Dimensions.dp24,
                right: Dimensions.dp24,
                top: Dimensions.dp35),
            decoration: const BoxDecoration(
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
            child: Row(
              children: [
                getSourceDestination("Adalaj Gam", "15 Oct 2022, 10:54 PM"),
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(ImageConstant.iArrowRight),
                ),
                getSourceDestination("Ahm Airport", "15 Oct 2022, 10:54 PM")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: Dimensions.dp24,
                right: Dimensions.dp24,
                top: Dimensions.dp35),
            decoration: const BoxDecoration(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 18, left: 18),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Passenger Details",
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGray),
                      ),
                      InkWell(
                        onTap: () {
                          openBottomSheetForPassengers();
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(vertical: 4, horizontal: 9),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  Dimensions.dp5,
                                ),
                              ),
                              border:
                                  Border.all(color: Theme.of(context).primaryColor)),
                          child: Text("Add Passenger",
                              style: satoshiRegular.copyWith(
                                  fontSize: Dimensions.dp10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Adults",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkGray),
                              ),
                              Text(
                                "$_addedAdultsCount",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGray),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              Text(
                                "Kids",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkGray),
                              ),
                              Text(
                                "$_addedKidsCount",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGray),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Total",
                            style: satoshiRegular.copyWith(
                                fontSize: Dimensions.dp12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGray),
                          ),
                          Text(
                            "${_addedAdultsCount+_addedKidsCount}",
                            style: satoshiRegular.copyWith(
                                fontSize: Dimensions.dp16.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.darkGray),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSourceDestination(String title, String schedule) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Text(
            title,
            style: satoshiRegular.copyWith(
                fontSize: Dimensions.dp16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray),
          ),
          Text(schedule,
              style: satoshiRegular.copyWith(
                  fontSize: Dimensions.dp10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray)),
        ],
      ),
    );
  }

  void openBottomSheetForPassengers() {
    int adultsCount = _addedAdultsCount;
    int kidsCount = _addedKidsCount;
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context,StateSetter setState) {
            return Container(
              height: 294,
              padding: const EdgeInsets.only(top: 22, right: 24, left: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Passengers",
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkGray),
                      ),
                      Text(
                        "Cancel",
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp14.sp,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Adults",
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGray),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (adultsCount > 0) {
                                adultsCount--;
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: 15,
                              width: 15,
                              color: AppColors.lightGrey,
                              child: const Center(
                                child: Icon(
                                  Icons.remove,
                                  size: 12,
                                  color: AppColors.darkGray,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "$adultsCount",
                              style: satoshiRegular.copyWith(
                                  fontSize: Dimensions.dp16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkGray),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // if(adultsCount>0){
                              adultsCount++;
                              setState(() {});
                              // }
                            },
                            child: Container(
                              height: 15,
                              width: 15,
                              color: Theme.of(context).primaryColor,
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kids",
                        style: satoshiRegular.copyWith(
                            fontSize: Dimensions.dp18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGray),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              if (kidsCount > 0) {
                                kidsCount--;
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: 15,
                              width: 15,
                              color: AppColors.lightGrey,
                              child: const Center(
                                child: Icon(
                                  Icons.remove,
                                  size: 12,
                                  color: AppColors.darkGray,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "$kidsCount",
                              style: satoshiRegular.copyWith(
                                  fontSize: Dimensions.dp16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkGray),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              kidsCount++;
                              setState(() {});
                            },
                            child: Container(
                              height: 15,
                              width: 15,
                              color: Theme.of(context).primaryColor,
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin:
                    const EdgeInsets.only(left: Dimensions.dp42, right: Dimensions.dp42, top: Dimensions.dp49),
                    child: CustomButton(
                      color: Theme.of(context).primaryColor,
                      text: "Add",
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        setPassengerData(adultsCount,kidsCount);
                        Navigator.pop(context);
                      },
                      style: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      height: Dimensions.dp53,
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }
  setPassengerData(int adultsCount, int kidsCount){
    _addedKidsCount = kidsCount;
    _addedAdultsCount = adultsCount;
    setState(() {

    });
  }
}
