import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/responseModels/feedback_status_list_item.dart';

class FeedBackStatusList extends StatefulWidget {
  final Function(int) selectedIndex;
  final List<FeedBackStatusListItem> list;
  const FeedBackStatusList({Key? key,required this.selectedIndex,required this.list}) : super(key: key);

  @override
  _FeedBackStatusListState createState() => _FeedBackStatusListState();
}

class _FeedBackStatusListState extends State<FeedBackStatusList> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    widget.selectedIndex(selectedIndex);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                selectedIndex=index;
                widget.selectedIndex(selectedIndex);
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                width: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      Dimensions.dp4,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      widget.list[index].imagePath,
                      color: selectedIndex == index
                          ? AppColors.primaryColor
                          : AppColors.darkGray,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:(widget.list[index].title.contains(' '))?2:7),
                      child: Text(
                        widget.list[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: poppinsRegularConst.copyWith(
                            fontSize: Dimensions.dp10.sp,
                            fontWeight: FontWeight.w500,
                            color: selectedIndex == index
                                ? AppColors.primaryColor
                                : AppColors.darkGray),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
