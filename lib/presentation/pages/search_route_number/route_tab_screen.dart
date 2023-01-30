import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RouteTabScreen extends StatefulWidget {
  final String title;

  const RouteTabScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<RouteTabScreen> createState() => _RouteTabScreenState();
}

class _RouteTabScreenState extends State<RouteTabScreen>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: Dimensions.dp25),
            CustomToolbar(
              title: widget.title,
              showOption: false,
              showFavourite: true,
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: Dimensions.dp50.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  top: Dimensions.dp10,
                  bottom: Dimensions.dp10,
                  left: Dimensions.dp40),
              child: Text(
                "ADAJAN G.S.R.T.C RAILWAY STATION...",
                style: satoshiRegularSmall,
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: TabBar(
                labelColor: Theme.of(context).primaryColor,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: 4.0,
                unselectedLabelColor: AppColors.lightGray,
                labelStyle: satoshiRegularSmallDark.copyWith(fontSize: 18),
                controller: _controller,
                tabs: const [
                  Tab(
                    text: '26 Stops',
                  ),
                  Tab(
                    text: 'TIMING',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.all(Dimensions.dp20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: 26,
                      itemBuilder: (context, index) {
                        return TimelineTile(
                          indicatorStyle: IndicatorStyle(
                              color: Theme.of(context).primaryColor, width: 10),
                          beforeLineStyle: const LineStyle(
                              thickness: 2, color: AppColors.darkGray),
                          axis: TimelineAxis.vertical,
                          alignment: TimelineAlign.manual,
                          lineXY: 0.10,
                          endChild: Container(
                            margin: const EdgeInsets.all(20),
                            constraints: const BoxConstraints(
                              minWidth: 120,
                            ),
                            color: Colors.white,
                            child: Text(
                              "PALANPUR",
                              style: satoshiRegularSmall.copyWith(
                                  color: AppColors.darkGray),
                            ),
                          ),
                          startChild: Container(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(Dimensions.dp20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 25, top: 10, bottom: 10),
                          child: const Divider(
                            color: AppColors.lightGray,
                          ),
                        );
                      },
                      itemCount: 26,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 25,),
                          constraints: const BoxConstraints(
                            minWidth: 120,
                          ),
                          color: Colors.white,
                          child: Text(
                            "PALANPUR",
                            style: satoshiRegularSmall.copyWith(
                                color: AppColors.darkGray),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: CustomButton(
                color: Theme.of(context).primaryColor,
                text: "Buy Ticket",
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                },
                style: satoshiRegular.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                height: Dimensions.dp53,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
