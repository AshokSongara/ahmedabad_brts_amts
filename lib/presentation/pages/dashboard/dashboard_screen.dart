import 'package:ahmedabad_brts_amts/presentation/pages/booking/booking_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/home_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/notification/notification_screen.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../maps/nearby_maps_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key, required this.pageIndex}) : super(key: key);

  int pageIndex;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  var ctime;

  @override
  void initState() {
    super.initState();
      _pageIndex = widget.pageIndex;
      _pageController = PageController(initialPage: _pageIndex);
    // });
    getMemberID();
  }

  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppConstant.IsLoggedIn = prefs.getString(AppConstant.accessToken) ?? "";
    AppConstant.nameData = prefs.getString(AppConstant.name) ?? "";
    AppConstant.emailData = prefs.getString(AppConstant.email) ?? "";
    AppConstant.lastNameData = prefs.getString(AppConstant.lastName) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () async {
             print("back back d");
            // DateTime now = DateTime.now();
            // if (ctime == null ||
            //     now.difference(ctime) > const Duration(seconds: 2)) {
            //   //add duration of press gap
            //   ctime = now;
            //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //       content: Text(
            //           'Press Back Button Again to Exit'))); //scaffold message, you can show Toast message too.
            //   return false;
            // }
            return false;
          },
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                _pageIndex = page;
              });
            },
            children: const [
              HomeScreen(),
              BookingScreen(from: "menu"),
              NotificationScreen(from: "menu"),
              NearByMapsScreen(from: "menu",stopType: "BRTS",)
            //  ProfileScreen(from: "menu")
            ],
          ),
        ),
        // bottomNavigationBar: Theme(
        //   data: Theme.of(context).copyWith(
        //       canvasColor: Theme.of(context).primaryColor,
        //       primaryColor: Theme.of(context).primaryColor,
        //       textTheme: Theme.of(context)
        //           .textTheme
        //           .copyWith(caption: const TextStyle(color: Colors.white30))),
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       color: Colors.transparent,
        //       backgroundBlendMode: BlendMode.clear,
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(30),
        //         topRight: Radius.circular(30),
        //       ),
        //       boxShadow: [
        //         BoxShadow(
        //             color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        //       ],
        //     ),
        //     height: MediaQuery.of(context).size.height * 0.085,
        //     child: Wrap(
        //       children: [
        //         BottomNavigationBar(
        //           currentIndex: _pageIndex,
        //           selectedItemColor: Colors.white,
        //           unselectedItemColor: Colors.white,
        //           type: BottomNavigationBarType.fixed,
        //           unselectedLabelStyle: satoshiRegular.copyWith(
        //               fontWeight: FontWeight.w400,
        //               color: Theme.of(context).primaryColor,
        //               fontSize: 13.sp),
        //           selectedLabelStyle: satoshiRegular.copyWith(
        //               fontWeight: FontWeight.w400,
        //               color: Theme.of(context).primaryColor,
        //               fontSize: 13.sp),
        //           items: [
        //             BottomNavigationBarItem(
        //               icon: _pageIndex == 0
        //                   ? const Padding(
        //                       padding: EdgeInsets.all(4.0),
        //                       child: ImageIcon(AssetImage(ImageConstant.iHome)),
        //                     )
        //                   : const Padding(
        //                       padding: EdgeInsets.all(4.0),
        //                       child: ImageIcon(AssetImage(ImageConstant.iHome)),
        //                     ),
        //               label: AppLocalizations.of(context)?.translate("home") ?? "",
        //             ),
        //             BottomNavigationBarItem(
        //               icon: _pageIndex == 1
        //                   ? const Padding(
        //                       padding: EdgeInsets.all(4.0),
        //                       child:
        //                           ImageIcon(AssetImage(ImageConstant.iBooking)),
        //                     )
        //                   : const Padding(
        //                       padding: EdgeInsets.all(4.0),
        //                       child:
        //                           ImageIcon(AssetImage(ImageConstant.iBooking)),
        //                     ),
        //               label: AppLocalizations.of(context)?.translate("booking") ?? "",
        //             ),
        //             BottomNavigationBarItem(
        //               icon: _pageIndex == 2
        //                   ? const Padding(
        //                       padding: EdgeInsets.all(4.0),
        //                       child: ImageIcon(
        //                           AssetImage(ImageConstant.iNotification)),
        //                     )
        //                   : const Padding(
        //                       padding: EdgeInsets.all(4.0),
        //                       child: ImageIcon(
        //                           AssetImage(ImageConstant.iNotification)),
        //                     ),
        //               label:AppLocalizations.of(context)?.translate("notification") ?? "",
        //             ),
        //             // BottomNavigationBarItem(
        //             //     icon: _pageIndex == 3
        //             //         ? const Padding(
        //             //             padding: EdgeInsets.all(4.0),
        //             //             child: ImageIcon(
        //             //                 AssetImage(ImageConstant.iProfile)),
        //             //           )
        //             //         : const Padding(
        //             //             padding: EdgeInsets.all(4.0),
        //             //             child: ImageIcon(
        //             //                 AssetImage(ImageConstant.iProfile)),
        //             //           ),
        //             //     label: "Profile")
        //             BottomNavigationBarItem(
        //                 icon: _pageIndex == 3
        //                     ? const Padding(
        //                   padding: EdgeInsets.all(4.0),
        //                   child: Icon(Icons.near_me),
        //                 )
        //                     : const Padding(
        //                   padding: EdgeInsets.all(4.0),
        //                   child: Icon(Icons.near_me),
        //                 ),
        //                 label: AppLocalizations.of(context)?.translate("near_me") ?? "")
        //           ],
        //           onTap: (index) {
        //             bottomTapped(index);
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // )
    );
  }

  void bottomTapped(int index) {
    setState(() {
      _pageIndex = index;
      _pageController.jumpToPage(index);
    });
  }
}
