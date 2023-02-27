import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/loader/overylay_loader.dart';
import '../../../helper/route_helper.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/image_constant.dart';
import '../../../utils/styles.dart';
import '../../blocs/nearby_stops/nearby_stops_bloc.dart';
import '../../blocs/nearby_stops/nearby_stops_event.dart';
import '../../blocs/nearby_stops/nearby_stops_state.dart';


class NearbyStopsScreen extends StatefulWidget {
  const NearbyStopsScreen(
      {Key? key, required this.title, required this.routeCode})
      : super(key: key);
  final String title;
  final String routeCode;

  @override
  State<NearbyStopsScreen> createState() => _NearbyStopsScreenState();
}

class _NearbyStopsScreenState extends State<NearbyStopsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NearByStopsBloc>(context)
        .add(GetNearByStopsEvent(widget.routeCode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(
              left: Dimensions.dp15, right: Dimensions.dp20),
          padding: const EdgeInsets.only(
              top: Dimensions.dp10, bottom: Dimensions.dp10),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(ImageConstant.iLeftArrow)),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.title,
                        style: screenTitle,
                      ),
                    ),
                  ),
                ],
              ),
              BlocConsumer<NearByStopsBloc, NearByStopsState>(
                  listener: (context, state) {
                if (state is GetNearByStopsLoadingState) {
                  Loader.show(context);
                } else {
                  Loader.hide();
                }
              }, builder: (context, state) {
                if (state is NearByStopsResponseState) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.model.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Get.toNamed(RouteHelper.getRouteSearchTab(
                                  widget.title,
                                  state.model.data?[index].routeId ?? ""));
                            },
                            title: Text(
                              state.model.data?[index].routeId ?? "",
                              style: satoshiRegularSmall.copyWith(
                                  color: AppColors.darkGray),
                            ),
                          );
                        }),
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        )));
  }
}
