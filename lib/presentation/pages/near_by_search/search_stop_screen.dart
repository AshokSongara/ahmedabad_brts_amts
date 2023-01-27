import 'package:ahmedabad_brts_amts/core/theme/theme_service.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NearBySearchStopScreen extends StatefulWidget {
  const NearBySearchStopScreen({Key? key}) : super(key: key);

  @override
  _NearBySearchStopScreenState createState() => _NearBySearchStopScreenState();
}

class _NearBySearchStopScreenState extends State<NearBySearchStopScreen> {
  NearMeResponse? nearMeResponse;
  NearMeResponse? localNearMeResponse;
  TextEditingController controller = TextEditingController();
  List<Data> nearMeList = [];
  List<Data> localNearMeList = [];

  @override
  void initState() {
    super.initState();
    localNearMeResponse = Get.arguments as NearMeResponse;
    nearMeList = localNearMeResponse?.data ?? [];
    localNearMeList = localNearMeResponse?.data ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Column(
        children: [
          SizedBox(height: Dimensions.dp25),
          CustomToolbar(
            title: "Search Stop",
            showOption: false,
          ),
          Container(
            margin: const EdgeInsets.only(
                left: Dimensions.dp24,
                right: Dimensions.dp24,
                top: Dimensions.dp26),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                localNearMeList = nearMeList.where((element) {
                  return element.stopName
                          ?.toLowerCase()
                          .contains(value.toLowerCase()) ??
                      false;
                }).toList();
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                  ),
                ),
                suffix: controller.text.isEmpty
                    ? SvgPicture.asset(ImageConstant.iSearch,
                        height: 20, width: 20)
                    : InkWell(
                        onTap: () {
                          controller.text = "";
                        },
                        child: SvgPicture.asset(
                          ImageConstant.iCancel,
                          height: 20,
                          width: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
              ),
              style: satoshiRegular.copyWith(
                  fontSize: Dimensions.dp18.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 1,
            color: AppColors.lightGray,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 53),
            focusColor: AppColors.greyF1F1F1,
            tileColor: AppColors.greyF1F1F1,
            title: Text(
              "Near by Stop",
              style: satoshiRegular.copyWith(
                  fontSize: Dimensions.dp18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGray),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              itemCount: localNearMeList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                  horizontalTitleGap: 0, minLeadingWidth: 0,
                      leading: SvgPicture.asset(ThemeService().theme == ThemeMode.light?
                        ImageConstant.iMarker:ImageConstant.iMarkerBlue,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left:Dimensions.dp7),
                        child: Text(
                          localNearMeList[index].stopName ?? "",
                          style: satoshiRegular.copyWith(
                              fontSize: Dimensions.dp18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray),
                        ),
                      ),
                      onTap: () {
                        Get.back(result: localNearMeList[index]);
                      },
                    ),
                    const Divider(
                      height: 1,
                      color: AppColors.lightGray,
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
