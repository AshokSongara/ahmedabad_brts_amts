import 'package:ahmedabad_brts_amts/presentation/widgets/base/route_title_widget.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/search_result_item.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(height: 25),
        Container(
          margin:
              EdgeInsets.only(left: Dimensions.dp15, right: Dimensions.dp20),
          padding:
              EdgeInsets.only(top: Dimensions.dp10, bottom: Dimensions.dp10),
          child: Row(
            children: [
              SvgPicture.asset(ImageConstant.iLeftArrow),
              Expanded(
                child: Center(
                  child: Text(
                    "Search Result",
                    style: screenTitle,
                  ),
                ),
              ),
              SvgPicture.asset(ImageConstant.iThreeDots),
            ],
          ),
        ),
        RouteTitleWidget(),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return SearchResultItem();
              }),
        ),
      ]),
    );
  }
}
