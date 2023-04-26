import 'package:flutter/material.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/favourite/my_routes_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/my_routes/my_routes_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';

class MyRoutesTabScreen extends StatefulWidget {
  const MyRoutesTabScreen({Key? key}) : super(key: key);

  @override
  State<MyRoutesTabScreen> createState() => _MyRoutesTabScreenState();
}

class _MyRoutesTabScreenState extends State<MyRoutesTabScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        body: Column(
          children: [
            const CustomToolbar(
              title: "myroutes",
              showOption: false,
            ),
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.zero, // this one make 0
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.white,
                indicatorWeight: 2,
                indicatorColor: Colors.green[100],
                tabs: const [
                  Tab( text: "Trips"),
                  Tab( text: "Routes")
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: _tabController,
                children: const [
                  MyRoutesScreen(),
                  MyRoutesScreenTwo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
