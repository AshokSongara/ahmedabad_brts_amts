import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/booking_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/home_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/notification_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/profile_screen.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key, required this.pageIndex}) : super(key: key);

  int pageIndex;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: _pageIndex);
  }

  var ctime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () {
            DateTime now = DateTime.now();
            if (ctime == null ||
                now.difference(ctime) > const Duration(seconds: 2)) {
              //add duration of press gap
              ctime = now;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'Press Back Button Again to Exit'))); //scaffold message, you can show Toast message too.
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: PageView(
            children: [
              HomeScreen(),
              BookingScreen(),
              NotificationScreen(),
              ProfileScreen()
            ],
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _pageIndex = page;
              });
            },
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: AppColors.primaryColor,
              primaryColor: AppColors.primaryColor,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: TextStyle(color: Colors.white30))),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              backgroundBlendMode: BlendMode.clear,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.085,
            child: BottomNavigationBar(
              currentIndex: _pageIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: satoshiRegular.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                  fontSize: 13
              ),
              selectedLabelStyle: satoshiRegular.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                  fontSize: 13),
              items: [
                BottomNavigationBarItem(
                  icon: _pageIndex == 0
                      ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ImageIcon(AssetImage(ImageConstant.iHome)),
                      )
                      : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ImageIcon(AssetImage(ImageConstant.iHome)),
                      ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: _pageIndex == 1
                      ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ImageIcon(AssetImage(ImageConstant.iBooking)),
                      )
                      : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ImageIcon(AssetImage(ImageConstant.iBooking)),
                      ),
                  label: "Booking",
                ),
                BottomNavigationBarItem(
                  icon: _pageIndex == 2
                      ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ImageIcon(AssetImage(ImageConstant.iNotification)),
                      )
                      : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ImageIcon(AssetImage(ImageConstant.iNotification)),
                      ),
                  label: "Notification",
                ),
                BottomNavigationBarItem(
                    icon: _pageIndex == 3
                        ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ImageIcon(AssetImage(ImageConstant.iProfile)),
                        )
                        : Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ImageIcon(AssetImage(ImageConstant.iProfile)),
                        ),
                    label: "Profile")
              ],
              onTap: (index) {
                bottomTapped(index);
              },
            ),
          ),
        ));
  }

  void bottomTapped(int index) {
    setState(() {
      _pageIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
}