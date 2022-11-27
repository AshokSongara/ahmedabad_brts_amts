import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/feedback_request_model.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_state.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/feedback/widgets/feedback_status_list.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/responseModels/feedback_status_list_item.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  int selectedIndex = 0;
  final List<FeedBackStatusListItem> list = [];

  @override
  void initState() {
    super.initState();
    list.add(
        FeedBackStatusListItem("Very Satisfied", ImageConstant.iMostSatisfied));
    list.add(FeedBackStatusListItem("Satisfied", ImageConstant.iSatisfied));
    list.add(FeedBackStatusListItem("Neutral", ImageConstant.iNeutral));
    list.add(
        FeedBackStatusListItem("Dissatisfied", ImageConstant.iDissatisfied));
    list.add(FeedBackStatusListItem(
        "Very Dissatisfied", ImageConstant.iVeryDissatisfied));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body:
          BlocConsumer<FeedbackBloc, FeedbackState>(listener: (context, state) {
        if (state is FeedbackLoadingState) {
          Loader.show(context);
        } else if (state is FeedbackResponseState) {
          Loader.hide();
        } else {
          Loader.hide();
        }
      }, builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: Dimensions.dp25),
            CustomToolbar(
              title: "My Routes",
              showOption: false,
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.only(right: 43, left: 39),
              children: [
                getQuestionWidget(
                    "1. What is the route number of the bus you are currently riding/rode?*"),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: TextField(
                    // controller: enterAmountController,
                    inputFormatters: [
                      // FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: satoshiRegular.copyWith(
                        fontSize: Dimensions.dp16.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.darkGray),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGray)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGray)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGray)),
                      errorBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor)),
                      disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGray)),
                      // contentPadding:
                      // const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Route number",
                      hintStyle: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp16.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.lightGray),
                    ),
                  ),
                ),
                getQuestionWidget(
                    "2. Thinking about your experience on any bus route in the last 30 days/last trip, how satisfied were you with:"),
                getQuestionWidget(
                    "a) The length of time you waited for the bus?*"),
                Padding(
                  padding: EdgeInsets.only(top: 22),
                  child: FeedBackStatusList(
                    list: list,
                    selectedIndex: (index) {
                      print("index of feedback Item selection $index");
                    },
                  ),
                ),
                getQuestionWidget("b) Your comfort on the bus?*"),
                Padding(
                  padding: EdgeInsets.only(top: 22),
                  child: FeedBackStatusList(
                    list: list,
                    selectedIndex: (index) {
                      print("index of feedback Item selection $index");
                    },
                  ),
                ),
                getQuestionWidget(
                    "3. How satisfied were you with the overall quality of service?"),
                Padding(
                  padding: EdgeInsets.only(top: 22),
                  child: FeedBackStatusList(
                    list: list,
                    selectedIndex: (index) {},
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: Dimensions.dp42,
                      right: Dimensions.dp42,
                      top: Dimensions.dp76,
                      bottom: 43),
                  child: CustomButton(
                    text: "Submit",
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      BlocProvider.of<FeedbackBloc>(context).add(
                        FeedbackSubmitEvent(
                          FeedbackRequestModel(
                              routeId: "4D",
                              waiting: 1,
                              comfort: 2,
                              crowding: 1,
                              serviceQuality: 2,
                              journey: "AtoB",
                              userId: 6),
                        ),
                      );
                    },
                    style: satoshiRegular.copyWith(
                        fontSize: Dimensions.dp18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    height: Dimensions.dp56,
                  ),
                ),
              ],
            )),
          ],
        );
      }),
    );
  }

  Widget getQuestionWidget(String question) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Text(
        question,
        style: satoshiRegular.copyWith(
            fontSize: Dimensions.dp16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGray),
      ),
    );
  }
}
