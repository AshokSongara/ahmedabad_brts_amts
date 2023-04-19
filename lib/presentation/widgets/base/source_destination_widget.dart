import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SourceDestinationWidget extends StatefulWidget {
  final String svgImageFile;
  final String title;
  final Widget contentTitle;
  //final String content;
  const SourceDestinationWidget({Key? key,required this.svgImageFile,required this.contentTitle,
   // required this.content,
    required this.title}) : super(key: key);

  @override
  _SourceDestinationWidgetState createState() => _SourceDestinationWidgetState();
}

class _SourceDestinationWidgetState extends State<SourceDestinationWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
          child: Container(
            height: Dimensions.dp70,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.dp18, top: Dimensions.dp13,bottom: Dimensions.dp13),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                          widget.svgImageFile),
                      const SizedBox(
                        width: Dimensions.dp14,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            widget.contentTitle,
                            // Text(
                            //   widget.content,
                            //   overflow: TextOverflow.fade,
                            //   maxLines: 1,
                            //   style: satoshiRegular.copyWith(
                            //       fontSize: Dimensions.dp12.sp,
                            //       fontWeight: FontWeight.w400,
                            //       color: AppColors.darkGray),
                            // ),
                          ],
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
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.dp10),
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.dp14.sp),
              ),
            )),
      ],
    );
  }
}
