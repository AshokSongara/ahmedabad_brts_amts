import 'package:ahmedabad_brts_amts/data/responsemodels/notification_list_item.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationListItem> list = [];
  @override
  void initState() {
    super.initState();
    list.add(NotificationListItem("Your bus Ramvatika to Sayan Railway Station has been reschedule to Monday, Mar 22 2022", "8:15 PM"));
    list.add(NotificationListItem("Your bus Ramvatika to Sayan Railway Station has been reschedule to Monday, Mar 22 2022", "8:15 PM"));
    list.add(NotificationListItem("Your bus Ramvatika to Sayan Railway Station has been reschedule to Monday, Mar 22 2022", "8:15 PM"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: Column(children: [
        SizedBox(height: Dimensions.dp25),
        CustomToolbar(
          title: "Notification",
          showOption: false,
        ),
        // SizedBox(height: Dimensions.dp20),
        
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context,index) {
              return Container(
                padding:  EdgeInsets.only(
                    left: Dimensions.dp19,
                    right: Dimensions.dp19,
                    top: Dimensions.dp14,
                bottom: Dimensions.dp10),
                margin: const EdgeInsets.only(
                    left: Dimensions.dp24,
                    right: Dimensions.dp24,
                    top: Dimensions.dp14),
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
                child: Row(children: [
                  SvgPicture.asset(
                    ImageConstant.iRedBus,
                    color: Theme.of(context).primaryColor,
                    width: 13,
                    height: 15,
                  ),
                  SizedBox(width: Dimensions.dp8,),
                  Expanded(
                    child: Text(
                      list[index].message,
                      style: satoshiSmall.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize:Dimensions.dp12,
                          color: AppColors.darkGray),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      list[index].time,
                      textAlign: TextAlign.end,
                      style: satoshiSmall.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize:Dimensions.dp12,
                          color: AppColors.lightGray),
                    ),
                  ),
                ],),
              );
            }
          ),
        ),
      ],),
    );
  }
}
