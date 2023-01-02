import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/notification_list_item.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/notification/notification_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/notification/notification_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/notification/notification_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatefulWidget {
  final String? from;

  const NotificationScreen({Key? key, required this.from}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationListItem> list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    BlocProvider.of<NotificationBloc>(context).add(GetNotificationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadingState) {
            Loader.show(context);
          } else if (state is NotificationSuccessState) {
            Loader.hide();
            return Column(
              children: [
                const SizedBox(height: Dimensions.dp25),
                CustomToolbar(
                  title: "notification",
                  showOption: false,
                  back: widget.from == "home" ? true : false,
                ),
                Expanded(
                  child: state.notificationResponse.data!.isEmpty
                      ? const Center(child: Text("No Notification"))
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.notificationResponse.data?.length,
                          itemBuilder: (context, index) {
                            return Container(
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
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageConstant.iRedBus,
                                    color: Theme.of(context).primaryColor,
                                    width: 13,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: Dimensions.dp8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.notificationResponse.data![index]
                                              .detail ??
                                          "",
                                      style: satoshiSmall.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: Dimensions.dp12,
                                          color: AppColors.darkGray),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("08:15 PM",
                                      textAlign: TextAlign.end,
                                      style: satoshiSmall.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: Dimensions.dp12,
                                          color: AppColors.lightGray),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                ),
              ],
            );
          } else if (state is NotificationFailedState) {
            Loader.hide();
          }
          return Container();
        },
      ),
    );
  }
}
