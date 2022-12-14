import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/near_by_map/near_by_map_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/near_by_map/near_by_map_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/near_by_map/near_by_map_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/dashedLine_painter.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';

class NearByMapsScreen extends StatefulWidget {
  const NearByMapsScreen({Key? key}) : super(key: key);

  @override
  State<NearByMapsScreen> createState() => _NearByMapsScreenState();
}

class _NearByMapsScreenState extends State<NearByMapsScreen> {
  MapController controller = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 23.194638, longitude: 72.42798),
  );
  NearMeResponse? nearMeResponse;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.enableTracking(enableStopFollow: false);
    _getNearByRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: BlocConsumer<NearByMapBloc, NearByMapState>(
          listener: (context, state) {
        if (state is NearByMapLoadingState) {
          Loader.show(context);
        } else if (state is NearByMapSuccessState) {
          Loader.hide();
          nearMeResponse = state.nearMeResponse;
        } else if (state is NearByMapFailState) {
          Loader.hide();
        }
      }, builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: Dimensions.dp25),
            CustomToolbar(
              title: "near_you",
              showOption: false,
            ),
            Expanded(
              flex: 1,
              child: OSMFlutter(
                controller: controller,
                trackMyPosition: true,
                initZoom: 12,
                minZoomLevel: 8,
                maxZoomLevel: 14,
                stepZoom: 1.0,
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 76,
                    ),
                  ),
                  directionArrowMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.double_arrow,
                      size: 48,
                    ),
                  ),
                ),
                roadConfiguration: RoadConfiguration(
                  startIcon: const MarkerIcon(
                    icon: Icon(
                      Icons.person,
                      size: 64,
                      color: Colors.brown,
                    ),
                  ),
                  roadColor: Colors.yellowAccent,
                ),
                markerOption: MarkerOption(
                    defaultMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.person_pin_circle,
                    color: Colors.blue,
                    size: 56,
                  ),
                )),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Near by bus stop",
                      style: satoshiRegular.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  IconButton(
                      onPressed: () {
                        _getNearByRoutes();
                      },
                      icon: Icon(Icons.refresh, color: Colors.white))
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: nearMeResponse != null
                  ? ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: nearMeResponse?.data?.length ?? 0,
                      separatorBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.dp20, right: Dimensions.dp20),
                          child: CustomPaint(painter: DashedLinePainter())),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            (nearMeResponse?.data?[index].stopName ?? "")
                                .toUpperCase(),
                            style: satoshiRegular.copyWith(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkGray),
                          ),
                          trailing: Text(
                              "${getDistanceInMeters(nearMeResponse?.data?[index].distance.toString() ?? "")} Mtr",
                              style: satoshiRegular.copyWith(
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.gray555555)),
                          onTap: () {
                            controller.changeLocation(GeoPoint(
                                latitude:
                                    nearMeResponse?.data?[index].latitude ?? 0,
                                longitude:
                                    nearMeResponse?.data?[index].longitude ??
                                        0));
                            setState(() {});
                          },
                        );
                      })
                  : Container(),
            ),
          ],
        );
      }),
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

      BlocProvider.of<NearByMapBloc>(context).add(
        NearByMapRouteEvent(nearMeRequest: nearByRequest),
      );
    }
  }
}
