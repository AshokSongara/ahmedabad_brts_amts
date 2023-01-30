import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchStopScreen extends StatefulWidget {
  final String selectedLanguage;
  const SearchStopScreen({Key? key,required this.selectedLanguage}) : super(key: key);

  @override
  _SearchStopScreenState createState() => _SearchStopScreenState();
}

class _SearchStopScreenState extends State<SearchStopScreen> {
  BrtsStopResponseModel? brtsStopResponseModel;
  BrtsStopResponseModel? localBrtsStopResponseModel;
  TextEditingController controller = TextEditingController();
  List<Data> brtsStopList = [];
  List<Data> localBrtsStopList = [];

  @override
  void initState() {
    super.initState();
    // brtsStopResponseModel = Get.arguments as BrtsStopResponseModel;
    localBrtsStopResponseModel = Get.arguments as BrtsStopResponseModel;
    brtsStopList = localBrtsStopResponseModel?.data ?? [];
    localBrtsStopList = localBrtsStopResponseModel?.data ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.profileBackgroundGrey,
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: Dimensions.dp25),
            const CustomToolbar(
              title: "search_stop",
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
                  localBrtsStopList = brtsStopList.where((element) {
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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                itemCount: localBrtsStopList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(widget.selectedLanguage == "gu"
                            ?localBrtsStopList[index].stopNameGujarati??"":
                          localBrtsStopList[index].stopName ?? "",
                          style: satoshiRegular.copyWith(
                              fontSize: Dimensions.dp18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray),
                        ),
                        onTap: () {
                          Get.back(result: localBrtsStopList[index]);
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
      ),
    );
  }
}
