import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';

class FailedTransactionScreen extends StatefulWidget {
  const FailedTransactionScreen({Key? key}) : super(key: key);

  @override
  State<FailedTransactionScreen> createState() =>
      _FailedTransactionScreenState();
}

class _FailedTransactionScreenState extends State<FailedTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteHelper.dashboard, (Route<dynamic> route) => false);

        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.appBackground2,
        body: SafeArea(
          child: Column(
            children: [
              CustomToolbar(
                title: "Transaction Status",
                showOption: false,
                type: "Payment",
              ),
              SizedBox(
                height: 200,
              ),
              SvgPicture.asset(
                ImageConstant.failed,
                color: Colors.red,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Transaction Failed",
                  style:
                      satoshiRegular.copyWith(fontSize: 25.sp, color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
