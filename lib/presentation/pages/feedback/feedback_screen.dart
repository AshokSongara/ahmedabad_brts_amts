import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/feedback_request_model.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_state.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/feedback/widgets/feedback_status_list.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
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
  final _routeController = TextEditingController();
  int feedbackOne = 0;
  int feedbackTwo = 0;
  int feedbackThree = 0;

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
          SafeArea(
            child: BlocConsumer<FeedbackBloc, FeedbackState>(listener: (context, state) {
        if (state is FeedbackLoadingState) {
            Loader.show(context);
        } else if (state is FeedbackResponseState) {
            Loader.hide();
            showCustomSnackBar("Feedback Submitted..!", context, isError: false);
            Navigator.of(context).pop();
        } else {
            Loader.hide();
        }
      }, builder: (context, state) {
        return Column(
            children: [
              // const SizedBox(height: Dimensions.dp25),
              CustomToolbar(
                title: "feedback",
                showOption: false,
              ),
              Expanded(
                  child: ListView(
                padding: const EdgeInsets.only(right: 43, left: 39),
                children: [
                  getQuestionWidget(
                      "1. What is the route number of the bus you are currently riding/rode?*"),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: TextField(
                      controller: _routeController,
                      style: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp16.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.darkGray),
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.lightGray)),
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
                    padding: const EdgeInsets.only(top: 22),
                    child: FeedBackStatusList(
                      list: list,
                      selectedIndex: (index) {
                        feedbackOne = index + 1;
                      },
                    ),
                  ),
                  getQuestionWidget("b) Your comfort on the bus?*"),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: FeedBackStatusList(
                      list: list,
                      selectedIndex: (index) {
                        feedbackTwo = index + 1;
                      },
                    ),
                  ),
                  getQuestionWidget(
                      "c) Level of crowding inside the bus?*"),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: FeedBackStatusList(
                      list: list,
                      selectedIndex: (index) {
                        feedbackOne = index + 1;
                      },
                    ),
                  ),
                  getQuestionWidget(
                      "d) Then information provide at the stop and on the bus?*"),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: FeedBackStatusList(
                      list: list,
                      selectedIndex: (index) {
                        feedbackOne = index + 1;
                      },
                    ),
                  ),
                  getQuestionWidget(
                      "e) How satisfied are you with the bus journey you made in terms of value for money?*"),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: FeedBackStatusList(
                      list: list,
                      selectedIndex: (index) {
                        feedbackOne = index + 1;
                      },
                    ),
                  ),
                  getQuestionWidget(
                      "3. How satisfied were you with the overall quality of service?"),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: FeedBackStatusList(
                      list: list,
                      selectedIndex: (index) {
                        feedbackThree = index + 1;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: Dimensions.dp42,
                        right: Dimensions.dp42,
                        top: Dimensions.dp76,
                        bottom: 43),
                    child: CustomButton(
                      color: Theme.of(context).primaryColor,
                      text: "Submit",
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        if (_routeController.text.isEmpty) {
                          showCustomSnackBar("Please Enter Route Code", context);
                        } else {
                          BlocProvider.of<FeedbackBloc>(context).add(
                            FeedbackSubmitEvent(
                              FeedbackRequestModel(
                                routeId: _routeController.text,
                                waiting: feedbackOne,
                                comfort: feedbackTwo,
                                crowding: feedbackThree,
                                serviceQuality: feedbackThree,
                                journey: "AtoB",
                              ),
                            ),
                          );
                        }
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
          ),
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
