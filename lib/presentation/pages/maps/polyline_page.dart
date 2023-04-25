import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:ahmedabad_brts_amts/data/responsemodels/routes_on_map_response.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/map_route_code/routes_on_map_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/map_route_code/routes_on_map_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/map_route_code/routes_on_map_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';

class PolylinePage extends StatefulWidget {

  final String? routeCode;

  const PolylinePage({Key? key, required this.routeCode}) : super(key: key);

  @override
  State<PolylinePage> createState() => _PolylinePageState();
}

class _PolylinePageState extends State<PolylinePage> {
  late List<Polyline> polylines = [];
  final MapController controller = MapController();
  RoutesOnMapResponse? nearMeResponse;
  List<Marker> markers = [];
  List<LatLng> points = [];

  @override
  void initState() {
    super.initState();
    _getNearByRoutes(widget.routeCode ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutesOnMapBloc, RoutesOnMapState>(
      listener: (context, state) {
        if (state is RoutesOnMapLoadingState) {
          Loader.show(context);
        } else if (state is RoutesOnMapSuccessState) {
          Loader.hide();
        } else if (state is RoutesOnMapFailState) {
          Loader.hide();
        }
      },
      builder: (context, state) {
        if (state is RoutesOnMapSuccessState) {
          nearMeResponse = state.routesOnMapResponse;
          if (nearMeResponse != null) {
            for (int i = 0; i < nearMeResponse!.data!.length; i++) {
              points.add(LatLng(double.parse(nearMeResponse!.data![i].stopLatitude ?? "") ?? 0.0,
                  double.parse(nearMeResponse!.data![i].stopLongitude ?? "") ?? 0.0));
              markers.add(Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(double.parse(nearMeResponse!.data![i].stopLatitude ?? "") ?? 0,
                  double.parse(nearMeResponse!.data![i].stopLongitude ?? "") ?? 0),
                builder: (ctx) =>
                    Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      message: nearMeResponse!.data![i].stopName,
                      child: SizedBox(
                        height: 5,
                        width: 10,
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.location_on_rounded,
                                color: Colors.greenAccent,
                                size: 48,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  i == nearMeResponse!.data!.length - 1
                                      ? "End"
                                      : "",
                                  style: satoshiRegular.copyWith(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ));
            }
            polylines.add(Polyline(
                points: points,
                strokeWidth: 4,
                color: Colors.blue,
                borderColor: Colors.black));
          }

          return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    CustomToolbar(
                      title: "Near You",
                      showOption: false,
                    ),
                    Flexible(
                      child: FlutterMap(
                        options: MapOptions(
                          center:
                          LatLng(points[0].latitude, points[0].longitude),
                          zoom: 14.2,
                          onTap: (tapPosition, point) {
                            setState(() {});
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                          ),
                          PolylineLayer(
                            polylines: polylines,
                            polylineCulling: true,
                          ),
                          MarkerLayer(
                            markers: markers,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        } else {}
        return Container();
      },
    );
  }

  void _getNearByRoutes(String routeCode) async {
    BlocProvider.of<RoutesOnMapBloc>(context).add(
      RoutesOnMapRouteEvent(routeCode: routeCode),
    );
}}
