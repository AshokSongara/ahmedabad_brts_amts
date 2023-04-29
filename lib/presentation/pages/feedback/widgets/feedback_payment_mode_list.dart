import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/responseModels/feedback_status_list_item.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/styles.dart';

class FeedbackPaymentModeList extends StatefulWidget {
  final Function(int) selectedIndex;
  final List<FeedBackStatusListItem> list2;
  const FeedbackPaymentModeList({Key? key, required this.selectedIndex, required this.list2}) : super(key: key);

  @override
  State<FeedbackPaymentModeList> createState() => _FeedbackPaymentModeListState();
}

class _FeedbackPaymentModeListState extends State<FeedbackPaymentModeList> {
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
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                selectedIndex = index;
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
                      widget.list2[index].imagePath,
                      color: selectedIndex == index
                          ? Theme.of(context).primaryColor
                          : AppColors.darkGray,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top:
                          (widget.list2[index].title.contains(' ')) ? 2 : 7),
                      child: Text(
                        widget.list2[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: poppinsRegularConst.copyWith(
                            fontSize: Dimensions.dp10.sp,
                            fontWeight: FontWeight.w500,
                            color: selectedIndex == index
                                ? Theme.of(context).primaryColor
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
