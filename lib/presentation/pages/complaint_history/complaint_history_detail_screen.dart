import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ComplainHistoryDetailScreen extends StatefulWidget {
  const ComplainHistoryDetailScreen({Key? key, this.title, this.date, this.subCat, this.busNo, this.stationId, this.route, this.landmark, this.description, this.processDefinitionKey, this.complaintReferenceId, this.mobile}) : super(key: key);

  final String? title;
  final String? date;
  final String? subCat;
  final String? busNo;
  final String? stationId;
  final String? route;
  final String? landmark;
  final String? description;
  final String? processDefinitionKey;
  final String? complaintReferenceId;
  final String? mobile;

  @override
  State<ComplainHistoryDetailScreen> createState() => _ComplainHistoryDetailScreenState();
}

class _ComplainHistoryDetailScreenState extends State<ComplainHistoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin:
              const EdgeInsets.only(left: Dimensions.dp15, right: Dimensions.dp20),
              padding:
              const EdgeInsets.only(top: Dimensions.dp10, bottom: Dimensions.dp10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(child: SvgPicture.asset(ImageConstant.iLeftArrow),
                    onTap: (){Get.back();},
                  ),
                  Text(widget.title ?? "",
                    style: screenTitle,
                    maxLines: 2,
                  ),
                  Container()
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: Dimensions.dp19,
                  right: Dimensions.dp19,
                  top: Dimensions.dp14,
                  bottom: Dimensions.dp10),
              margin: const EdgeInsets.only(
                  left: Dimensions.dp24,
                  right: Dimensions.dp24,
                  top: Dimensions.dp14),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      getTextWidget("Reference Id", widget.complaintReferenceId ?? ""),


                    ],
                  ),
                  SizedBox(
                    height: 25.sp,
                  ),
                  getTextWidget("Title", widget.title ?? ""),
                  getTextWidget("Incident occurred date", formatDate(widget.date ?? "")),
                  getTextWidget("Incident occurred time", formatTime(widget.date ?? "")),
                  getTextWidget("Category",  "Complaint"),
                  getTextWidget("Sub Category", widget.subCat ?? ""),
                  getTextWidget("Bus Number", widget.busNo ?? ""),
                  getTextWidget("Station Id", widget.stationId ?? ""),
                  getTextWidget("Route", widget.route ?? ""),
                  getTextWidget("Landmark", widget.landmark ?? ""),
                  getTextWidget("Incident Description", widget.description ?? ""),
                  getTextWidget("Mobile Number", widget.mobile ?? ""),


                  // Text(
                  //   state.complaintHistoryResponse
                  //       .data![index].title ??
                  //       "",
                  //   style: satoshiSmall.copyWith(
                  //       fontWeight: FontWeight.w700,
                  //       fontSize: Dimensions.dp18.sp,
                  //       color: Colors.red),
                  // ),
                  // SizedBox(
                  //   height: 15.sp,
                  // ),
                  // Text(
                  //   state.complaintHistoryResponse
                  //       .data![index].subCategoryName!
                  //       .replaceAll("_", " ") ??
                  //       "",
                  //   style: satoshiSmall.copyWith(
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: Dimensions.dp16.sp,
                  //       color: AppColors.black),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat('dd/MM/yy').format(dateTime);
    return formattedDate;
  }

  String formatTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat('hh:mm a').format(dateTime);
    return formattedDate;
  }

  Widget getTextWidget(String title, String content){
    return  Padding(
      padding: EdgeInsets.only(bottom: 20.sp),
      child: RichText(
        text: TextSpan(
          text: "$title : ",
          style: satoshiRegular.copyWith(
              fontSize: Dimensions.dp16.sp, color: AppColors.black, fontWeight: FontWeight.w700),
          children: <TextSpan>[
            TextSpan(
                text: content,
                style: satoshiSmall.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.dp15.sp,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,)),
          ],
        ),
      ),
    );
  }
}
