import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/dashedLine_painter.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/nearby_item_widget.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({Key? key}) : super(key: key);

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  final _serviceController = TextEditingController();
  final FocusNode _serviceFocus = FocusNode();
  NearMeResponse? nearMeResponse;
  Data? data;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getNearByRoutes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: BlocConsumer<NearMeBloc, NearmeState>(
        listener: (context, state) {
          if (state is NearMeSuccessState) {
            nearMeResponse = state.nearMeResponse;
          }
        },
        builder: (context, state) {
          if (state is NearMeLoadingState) {
            Loader.show(context);
          } else if (nearMeResponse != null) {
            Loader.hide();
            return Column(
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.4,
                      color: Theme.of(context).primaryColor,
                      child: Column(children: [
                        const SizedBox(height: 25),
                        Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.dp15, right: Dimensions.dp20),
                          padding: const EdgeInsets.only(
                              top: Dimensions.dp10, bottom: Dimensions.dp10),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                  ImageConstant.iLeftArrow,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                            ?.translate("near_you") ??
                                        "",
                                    style: screenTitle.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.dp30,
                              right: Dimensions.dp30,
                              top: Dimensions.dp20),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 14),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.dp10),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              data = await Get.toNamed(
                                  RouteHelper.getNearBySearchStopScreenRoute(),
                                  arguments: nearMeResponse) as Data;
                              print(data?.stopName ?? "");
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageConstant.iSearch,
                                    height: 20, width: 20),
                                SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: Text(
                                    "Nigam Nagar, Chandkheda, Ahmedabad, Gujara...",
                                    overflow: TextOverflow.fade,
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.lightGray),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.dp20,
                        ),
                        Container(
                          height: Dimensions.dp45,
                          margin: const EdgeInsets.only(
                              left: Dimensions.dp30, right: Dimensions.dp30),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(Dimensions.dp50))),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.nearbyMap);
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      ImageConstant.iCurrentLocation),
                                  const SizedBox(
                                    width: Dimensions.dp10,
                                  ),
                                  Text(
                                    "VIEW ON MAP",
                                    style: satoshiSmall.copyWith(
                                        fontSize: 14.sp, color: Colors.white),
                                  ),
                                ]),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(Dimensions.dp20),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Container(
                                margin: const EdgeInsets.only(
                                    left: Dimensions.dp20,
                                    right: Dimensions.dp20),
                                child:
                                    CustomPaint(painter: DashedLinePainter())),
                            padding: const EdgeInsets.only(top: 10),
                            itemCount: nearMeResponse?.data?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return NearByItemWidget(
                                  nearme: nearMeResponse!.data![index]);
                            })),
                  ),
                )
              ],
            );
          } else {
            Loader.hide();
            return Container();
          }
          return Container();
        },
      ),
    );
  }

  void _getNearByRoutes() async {
    Location location = Location();
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    await location.requestService();

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      debugPrint("Location Permission Denied :(");
      _permissionGranted = await location.requestPermission();
    } else {
      _locationData = await location.getLocation();

      var nearByRequest = NearMeRequest();
      nearByRequest.latitude = _locationData.latitude;
      nearByRequest.longitude = _locationData.longitude;
      nearByRequest.stopType = 2;

      BlocProvider.of<NearMeBloc>(context).add(
        GetNearMeRouteEvent(nearMeRequest: nearByRequest),
      );
    }
  }
}
