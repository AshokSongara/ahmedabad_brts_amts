import 'package:ahmedabad_brts_amts/data/requestmodels/complaint_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/routes_request_model.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/stop_request_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint/complaint_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint/complaint_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/language/language_cubit.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../blocs/complaint/complaint_event.dart';

class ComplaintScreen extends StatefulWidget {
  String? stopType;

  ComplaintScreen({Key? key, this.stopType}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  BrtsStopResponseModel? operationBrtsStopResponseModel;
  BrtsRoutesResponseModel? brtsRoutesResponseModel;

  String? selectedLanguage = "en";
  final _title = TextEditingController();
  final _landmark = TextEditingController();
  final _incidentDescription = TextEditingController();
  final _mobileNumber = TextEditingController();
  final _busNumber = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedSubCategory;

  Map<String, String> categoryCodes = {
    'Bus related': '8001',
    'Station related': '8002',
    'Manpower related': '8003',
    'Others': '8004',
  };

  String? selectedCategoryCode;

  //bool isAmts = false;
  String selectedString = "Tap to select station id";
  String selectedStringRoute = "Tap to select route number";

  @override
  void initState() {
    super.initState();
    context.read<LanguageCubit>().getCurrentSelectedLanguage().then((value) {
      selectedLanguage = value;
      BlocProvider.of<ComplaintBloc>(context).add(GetAvailableStopsEvent(
          StopRequestModel(stopType: widget.stopType! == "AMTS" ? 2 : 1)));
      BlocProvider.of<ComplaintBloc>(context).add(GetAvailableRoutesEvent(
          RoutesRequestModel(stopType: widget.stopType! == "AMTS"? 2 : 1)));
    });
  }

  Future<void> _selectDate() async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (datePicked != null && datePicked != selectedDate) {
      setState(() {
        selectedDate = datePicked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (timePicked != null && timePicked != selectedTime) {
      setState(() {
        selectedTime = timePicked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBackground2,
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: BlocConsumer<ComplaintBloc, ComplaintState>(
            listener: (context, state) {
              if (state is StopsResponseState) {
                setState(() {
                  operationBrtsStopResponseModel = state.model;
                });
              }
              if (state is RoutesResponseState) {
                setState(() {
                  brtsRoutesResponseModel = state.model;
                });
              }
            },
            builder: (context, state) {
              if (operationBrtsStopResponseModel == null ||
                  operationBrtsStopResponseModel!.data == null ||
                  operationBrtsStopResponseModel!.data!.isEmpty) {
                // Return a loading or empty state widget
                return Center(
                    child:
                        CircularProgressIndicator()); // Replace with your custom loading or empty state widget
              } else {
                // Continue rendering the rest of the UI with the available data
                return SafeArea(
                  child: Column(
                    children: [
                      CustomToolbar(
                        title: "complaint",
                        showOption: false,
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.only(right: 43, left: 39),
                          children: [
                            getQuestionWidget("Title", Colors.red),
                            SizedBox(height: 10.h,),
                            Container(
                              height: 42.h,
                              padding: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(

                                controller: _title,
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.darkGray),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor)),
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  hintText: 'Enter title',
                                  hintStyle: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.lightGray),
                                ),
                              ),
                            ),
                            getQuestionWidget(
                                "Incident date *", Colors.red),
                            SizedBox(
                              height: 10.sp,
                            ),
                            GestureDetector(
                              onTap: _selectDate,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  selectedDate != null
                                      ? _formatDate(selectedDate!)
                                      : 'Tap to select date',
                                  style: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: selectedDate != null
                                          ? AppColors.black
                                          : AppColors.lightGray),
                                ),
                              ),
                            ),
                            getQuestionWidget("Incident time", Colors.red),
                            SizedBox(
                              height: 10.sp,
                            ),
                            GestureDetector(
                              onTap: _selectTime,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  selectedTime != null
                                      ? _formatTime(selectedTime!)
                                      : 'Tap to select time',
                                  style: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: selectedTime != null
                                          ? AppColors.black
                                          : AppColors.lightGray),
                                ),
                              ),
                            ),
                            // getQuestionWidget("Category *"),
                            // SizedBox(
                            //   height: 10.sp,
                            // ),
                            // Container(
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Padding(
                            //         padding:
                            //             EdgeInsets.symmetric(horizontal: 8.sp),
                            //         child: Text(
                            //           'Complaint',
                            //           style: satoshiRegular.copyWith(
                            //               fontSize: Dimensions.dp18.sp,
                            //               fontWeight: FontWeight.w500,
                            //               color: AppColors.black),
                            //         ),
                            //       ),
                            //       Container(
                            //         height: 0.5,
                            //         color: Colors.grey,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            getQuestionWidget("Category", Colors.red),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Tap to select category',
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp16.sp,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.lightGray),
                                  ),
                                  value: selectedSubCategory,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedSubCategory = newValue;
                                      selectedCategoryCode = categoryCodes[newValue!];
                                    });
                                  },
                                  dropdownColor: Colors.white,
                                  items: categoryCodes.keys.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp18.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            getQuestionWidget("Bus Number", Colors.white),
                            SizedBox(height: 10.h,),
                            Container(
                              height: 42.h,
                              padding: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(

                                controller: _busNumber,
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.darkGray),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor)),
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  hintText: 'Enter bus number',
                                  hintStyle: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.lightGray),
                                ),
                              ),
                            ),
                            getQuestionWidget(
                                "Station id",
                                selectedSubCategory == "Station related"
                                    ? Colors.red
                                    : Colors.white),
                            SizedBox(
                              height: 10.sp,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  selectedString,
                                  style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: selectedString ==
                                            "Tap to select station id"
                                        ? AppColors.lightGray
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                print(selectedLanguage);
                                final result = await Get.toNamed(
                                  RouteHelper.getSearchStopScreenRoute(
                                      selectedLanguage ?? "", widget.stopType ?? "BRTS"),
                                  arguments: operationBrtsStopResponseModel,
                                );
                                if (result != null && result is DataHive) {
                                  setState(() {
                                  selectedString = result.stopName ?? "";
                                  });
                                }
                              },
                            ),
                            getQuestionWidget("Route number", Colors.white),
                            SizedBox(
                              height: 10.sp,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  selectedStringRoute,
                                  style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: selectedStringRoute ==
                                            "Tap to select route number"
                                        ? AppColors.lightGray
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                print(selectedLanguage);
                                final result = await Get.toNamed(
                                    RouteHelper.getSearchRouteScreenRoute(
                                        selectedLanguage ?? "", "com",widget.stopType == "AMTS"? "AMTS" : "BRTS"),
                                    arguments: [
                                      brtsRoutesResponseModel,
                                      widget.stopType == "AMTS" ? true : false
                                    ]);
                                if (result != null && result is RouteData) {
                                  setState(() {
                                    selectedStringRoute = result.routeCode ?? "";
                                  });
                                }
                              },
                            ),
                            getQuestionWidget("Landmark", Colors.white),
                            SizedBox(height: 10.h,),
                            Container(
                              height: 42.h,
                              padding: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller: _landmark,
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.darkGray),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor)),
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  hintText: 'Enter landmark',
                                  hintStyle: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.lightGray),
                                ),
                              ),
                            ),
                            getQuestionWidget(
                                "Incident Description", Colors.white),
                            SizedBox(height: 10.h,),
                            Container(
                              height: 42.h,
                              padding: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller: _incidentDescription,
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.darkGray),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor)),
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  hintText: 'Enter incident description',
                                  hintStyle: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.lightGray),
                                ),
                              ),
                            ),
                            getQuestionWidget("Mobile number", Colors.red),
                            SizedBox(height: 10.h,),
                            Container(
                              height: 42.h,
                              padding: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller: _mobileNumber,
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.darkGray),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor)),
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.lightGray)),
                                  hintText: 'Enter mobile number',
                                  hintStyle: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.lightGray),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25.sp,
                            ),
                            CustomButton(
                              color: Theme.of(context).primaryColor,
                              text: "Submit",
                              width: MediaQuery.of(context).size.width,
                              onPressed: () {
                                if (_title.text.toString().isEmpty) {
                                  showCustomSnackBar(
                                      "Please Enter Title", context);
                                } else if (selectedDate == null ||
                                    selectedDate.toString() ==
                                        'Tap to select date') {
                                  showCustomSnackBar(
                                      "Please Select Incident Occur Date",
                                      context);
                                } else if (selectedTime == null ||
                                    selectedTime.toString() ==
                                        'Tap to select time') {
                                  showCustomSnackBar(
                                      "Please Select Incident Occur Time",
                                      context);
                                } else if (selectedSubCategory == null) {
                                  showCustomSnackBar(
                                      "Please Select Category", context);
                                } else if (selectedSubCategory ==
                                        "Station related" &&
                                    selectedString ==
                                        "Tap to select station id") {
                                  showCustomSnackBar(
                                      "Please Select Station id", context);
                                } else if (_mobileNumber.text
                                    .toString()
                                    .isEmpty) {
                                  showCustomSnackBar(
                                      "Please Enter Mobile Number", context);
                                } else if (_mobileNumber.text.length != 10) {
                                  showCustomSnackBar(
                                      "Please Enter a Valid Mobile Number",
                                      context);
                                } else {
                                  print("submit pressed");
                                  var request = ComplaintRequest();
                                  request.title = _title.text;
                                  request.date = _formatDateBack(selectedDate!);
                                  request.time = formatSelectedTime(selectedTime!);
                                  request.category = 8000;
                                  request.subCategory = int.parse(selectedCategoryCode!);
                                  request.busNo = _busNumber.text;
                                  request.stationId = selectedString.toString();
                                  request.route = selectedStringRoute.toString();
                                  request.landmark = _landmark.text;
                                  request.description = _incidentDescription.text;
                                  request.mobile = _mobileNumber.text;
                                  request.severnity = 2;

                                  print(request.time);
                                  print(request.subCategory);
                                  print(request.date);

                                  BlocProvider.of<ComplaintBloc>(context).add(
                                    ComplaintUserEvent(data: request),
                                  );
                                  showCustomSnackBar(
                                      "Complaint Submitted", context,
                                      isError: false);
                                  Get.close(2);
                                }
                              },
                              style: poppinsMedium.copyWith(
                                  color: Colors.white, fontSize: 15.sp),
                              height: 53,
                            ),
                            SizedBox(
                              height: 200.sp,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }

  Widget getQuestionWidget(String question, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: RichText(
        text: TextSpan(
          text: question,
          style: satoshiRegular.copyWith(fontSize: 14, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: "* ",
                style: satoshiRegular.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w700, color: color)),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE, dd MMM yy');
    return formatter.format(date);
  }

  String _formatDateBack(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }

  String _formatTimeBack(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
    DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final DateFormat formatter = DateFormat('hh:mm:ss');
    return formatter.format(dateTime);
  }

  String formatSelectedTime(TimeOfDay? time) {
    if (time != null) {
      final now = DateTime.now();
      final selectedDateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
      final formatter = DateFormat('HH:mm:ss');
      return formatter.format(selectedDateTime);
    }
    return 'Tap to select time';
  }
}
