import 'package:ahmedabad_brts_amts/data/responsemodels/fare_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDialog extends StatelessWidget {
  final DataFare? data;
  final DataSearch? data2;
  final bool isLoading;
  final Function() onCancel;
  final Function() onProceed;

  MyDialog({required this.data, required this.isLoading, required this.onCancel, required this.onProceed,required this.data2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        height: 100.h,
            child: Column(
              children: [
                Text(' Fare: ₹ ${getFare(data?.adult ?? 0)}', style: satoshiRegular.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.darkGray),),
                SizedBox(height: 30.h,),
                Expanded(
                  child: Text("${data2!.routeDetails![0].startStopName} - ${data2!.interChanges!.isEmpty ? data2!.routeDetails![0].endStopName ?? "" :  data2!.routeDetails![data2!.routeDetails!.length - 1].endStopName ?? ""}", style: satoshiRegular.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBlue),),
                )
              ],
            ),
          ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: onCancel,
        ),
        TextButton(
          child: Text('Proceed'),
          onPressed: onProceed,
        ),
      ],
    );
  }
}

