import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint_history/complaint_history_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint_history/complaint_history_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint_history/complaint_history_state.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/complaint_history/complaint_history_detail_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintHistoryScreen extends StatefulWidget {
  const ComplaintHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintHistoryScreen> createState() => _ComplaintHistoryScreenState();
}

class _ComplaintHistoryScreenState extends State<ComplaintHistoryScreen> {
  String token = "";

  @override
  void initState() {
    super.initState();
    getMemberID();
  }

  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(AppConstant.accessToken) ?? "";
    if (token.isNotEmpty) {
      getData();
    }
  }

  getData() {
    BlocProvider.of<ComplaintHistoryBloc>(context)
        .add(GetComplaintHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: SafeArea(
        child: BlocBuilder<ComplaintHistoryBloc, ComplaintHistoryState>(
          builder: (context, state) {
            if (state is ComplaintHistoryLoadingState) {
              Loader.show(context);
            } else if (state is ComplaintHistorySuccessState) {
              Loader.hide();
              return Column(
                children: [
                  // const SizedBox(height: Dimensions.dp25),
                  CustomToolbar(
                    title: "complaint_history",
                    showOption: false,
                    back: true,
                  ),
                  Expanded(
                    child: state.complaintHistoryResponse.data!.isEmpty
                        ? const Center(child: Text("No data found"))
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount:
                                state.complaintHistoryResponse.data?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Get.to(ComplainHistoryDetailScreen(
                                    title: state.complaintHistoryResponse
                                        .data![index].title ??
                                        "",
                                    date: state.complaintHistoryResponse
                                        .data![index].date ??
                                        "",
                                    subCat: state.complaintHistoryResponse
                                      .data![index].subCategoryName ??
                                    "",
                                    busNo: state.complaintHistoryResponse
                                        .data![index].busNo ??
                                        "",
                                    stationId: state.complaintHistoryResponse
                                        .data![index].stationId ??
                                        "",
                                    route: state.complaintHistoryResponse
                                        .data![index].route ??
                                        "",
                                    landmark: state.complaintHistoryResponse
                                        .data![index].landmark ??
                                        "",
                                    description: state.complaintHistoryResponse
                                        .data![index].description ??
                                        "",
                                    processDefinitionKey: state.complaintHistoryResponse
                                        .data![index].processDefinitionKey ??
                                        "",
                                    complaintReferenceId: state.complaintHistoryResponse
                                        .data![index].complaintReferenceId ??
                                        "",
                                    mobile: state.complaintHistoryResponse
                                        .data![index].mobile ??
                                        "",
                                  ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.dp19,
                                      right: Dimensions.dp19,
                                      top: Dimensions.dp14,
                                      bottom: Dimensions.dp10),
                                  margin: const EdgeInsets.only(
                                      left: Dimensions.dp24,
                                      right: Dimensions.dp24,
                                      top: Dimensions.dp14),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.gray6E8EE7,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.dp10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            formatDate(state
                                                    .complaintHistoryResponse
                                                    .data![index]
                                                    .date ??
                                                ""),
                                            style: satoshiSmall.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: Dimensions.dp14.sp,
                                                color: AppColors.black),
                                          ),
                                          Text(
                                            formatTime(state
                                                    .complaintHistoryResponse
                                                    .data![index]
                                                    .date ??
                                                ""),
                                            style: satoshiSmall.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: Dimensions.dp14.sp,
                                                color: AppColors.black),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.sp,
                                      ),
                                      Text(
                                        state.complaintHistoryResponse
                                                .data![index].title ??
                                            "",
                                        style: satoshiSmall.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: Dimensions.dp18.sp,
                                            color: Colors.red),
                                      ),
                                      SizedBox(
                                        height: 15.sp,
                                      ),
                                      Text(
                                        state.complaintHistoryResponse
                                                .data![index].subCategoryName!
                                                .replaceAll("_", " ") ??
                                            "",
                                        style: satoshiSmall.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: Dimensions.dp16.sp,
                                            color: AppColors.black),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ),
                ],
              );
            } else if (state is ComplaintHistoryFailedState) {
              Loader.hide();
            }
            return Container();
          },
        ),
      ),
    );
  }

  String formatDate(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat('dd/MM/yy').format(dateTime);
    return formattedDate;
  }

  String formatTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat('hh:mm a').format(dateTime);
    return formattedDate;
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }
}
