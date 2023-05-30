import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latLng;

class NearByMapsScreen extends StatefulWidget {
  final String? stopType;
  final String? from;
  const NearByMapsScreen({Key? key, this.stopType, this.from}) : super(key: key);

  @override
  State<NearByMapsScreen> createState() => _NearByMapsScreenState();
}

class _NearByMapsScreenState extends State<NearByMapsScreen> {
  final MapController controller = MapController();
  NearMeResponse? nearMeResponse;
  List<Marker> markers = [];


  @override
  void initState() {
    super.initState();
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
              if (nearMeResponse != null) {
                for (Data data in nearMeResponse!.data!) {
                  markers.add(Marker(
                    width: 80.0,
                    height: 80.0,
                    point: latLng.LatLng(data.latitude??0,data.longitude??0),
                    builder: (ctx) =>
                        Tooltip(
                          triggerMode: TooltipTriggerMode.tap,
                          message: data.stopName,
                          child: const Icon(
                            Icons.location_on_rounded,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                  ));
                  controller.move(latLng.LatLng(data.latitude??0,data.longitude??0), 9.2);
                }
              }
            } else if (state is NearByMapFailState) {
              Loader.hide();
            }
          }, builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
               CustomToolbar(
                title: "near_me",
                showOption: false,
                back:  true,
              ),
              Expanded(
                flex: 1,
                child: FlutterMap(
                  mapController: controller,
                  options: MapOptions(
                    center: latLng.LatLng(23.033863,72.585022),
                    zoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: markers,
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: [
                    const SizedBox(
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
                            "${getDistanceInMeters(nearMeResponse?.data?[index].distance.toString() ?? "")}",
                            style: satoshiRegular.copyWith(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray555555)),
                        onTap: () {
                          Get.toNamed(RouteHelper.getNearByStops(
                              nearMeResponse?.data?[index].stopName ?? "",
                              nearMeResponse?.data?[index].stopCode??"",
                          widget.stopType ?? "",
                          widget.from ?? ""));

                          // controller.goToLocation(GeoPoint(
                          //     latitude:
                          //     nearMeResponse?.data?[index].latitude ??
                          //         0,
                          //     longitude:
                          //     nearMeResponse?.data?[index].longitude ??
                          //         0));
                          setState(() {});
                        },
                      );
                    })
                    : Container(),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
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
      nearByRequest.stopType = int.parse(widget.stopType ?? "1");
      markers.add( Marker(
        width: 80.0,
        height: 80.0,
        point: latLng.LatLng(_locationData.latitude??0,_locationData.longitude??0),
        builder: (ctx) =>
        const Icon(
          Icons.person_pin_circle,
          color: Colors.blue,
        ),
      ));
      // controller.addMarker(
      //     GeoPoint(
      //         latitude: _locationData.latitude ?? 0,
      //         longitude: _locationData.longitude ?? 0),
      //     markerIcon: const MarkerIcon(
      //         icon: Icon(
      //       Icons.person_pin_circle,
      //       color: Colors.blue,
      //       size: 76,
      //     )));
      BlocProvider.of<NearByMapBloc>(context).add(
        NearByMapRouteEvent(nearMeRequest: nearByRequest),
      );
    }
  }
}
