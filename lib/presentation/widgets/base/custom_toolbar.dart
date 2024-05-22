import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_event.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../data/responsemodels/brts_stop_respons_model.dart';

class CustomToolbar extends StatelessWidget {
  const CustomToolbar(
      {Key? key,
      required this.title,
      this.showOption = true,
        this.actionWidget,
        this.showFavourite = false,
      this.back = true,
        this.type = "Normal"})
      : super(key: key);
  final String title;
  final bool showOption;
  final bool showFavourite;
  final bool back;
  final Widget? actionWidget;
  final String? type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(left: Dimensions.dp15, right: Dimensions.dp20),
      padding:
          const EdgeInsets.only(top: Dimensions.dp10, bottom: Dimensions.dp10),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                if (type == "Payment") {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(RouteHelper.dashboard, (Route<dynamic> route) => false);
                  BlocProvider.of<HomeScreenBloc>(context).add(
                      TicketBookedEvent(DataHive()));
                }else if (type == "Passenger") {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(RouteHelper.dashboard, (Route<dynamic> route) => false);
                }
                else if (type == "History") {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(RouteHelper.booking, (Route<dynamic> route) => false);
                }
                else{
                  Get.back();
                }
              },
              child: Visibility(
                  visible: back,
                  child: SvgPicture.asset(ImageConstant.iLeftArrow))),
          Expanded(
            child: Center(
              child: Text(
                AppLocalizations.of(context)?.translate(title) ?? "",
                style: screenTitle,
              ),
            ),
          ),
          if (showFavourite)
            SvgPicture.asset(ImageConstant.iEmptyFavorite,
                color: Theme.of(context).primaryColor),
          if(actionWidget!=null) actionWidget!,
        ],
      ),
    );
  }
}
