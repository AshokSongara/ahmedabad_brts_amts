import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
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
import 'package:location/location.dart';

import '../../widgets/base/custom_search_bar.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({Key? key}) : super(key: key);

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  final _serviceController = TextEditingController();
  final FocusNode _serviceFocus = FocusNode();

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
      body: BlocBuilder<NearMeBloc, NearmeState>(
        builder: (context, state) {
          if (state is NearMeLoadingState) {
            Loader.show(context);
          } else if (state is NearMeSuccessState) {
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
                              SvgPicture.asset(
                                ImageConstant.iLeftArrow,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Near you",
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
                          child: CustomSearchBar(
                            controller: _serviceController,
                            focusNode: _serviceFocus,
                            nextFocus: _serviceFocus,
                            radius: 10,
                            onChanged: (text) {},
                            onSubmit: () {},
                            prefixIcon: ImageConstant.iSearch,
                            capitalization: TextCapitalization.words,
                            divider: false,
                            hintText:
                                "Nigam Nagar, Chandkheda, Ahmedabad, Gujara...",
                            fillColor: Colors.white,
                            hintStyle: satoshiSmall.copyWith(
                                color: AppColors.lightGray, fontSize: 13.sp),
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
                          child: Container(
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
                            itemCount: state.nearMeResponse.data?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return NearByItemWidget(
                                  nearme: state.nearMeResponse.data![index]);
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

  void _getNearByRoutes() async{
    Location location = Location();
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    await location.requestService();

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      debugPrint("Location Permission Denied :(");
      _permissionGranted = await location.requestPermission();
    }
    else {
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
