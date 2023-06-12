import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchStopScreen extends StatefulWidget {
  final String selectedLanguage;
  final String? stopType;
  final String? from;
   SearchStopScreen({Key? key,required this.selectedLanguage, this.stopType, this.from}) : super(key: key);

  @override
  _SearchStopScreenState createState() => _SearchStopScreenState();
}

class _SearchStopScreenState extends State<SearchStopScreen> {
  BrtsStopResponseModel? brtsStopResponseModel;
  BrtsStopResponseModel? localBrtsStopResponseModel;
  TextEditingController controller = TextEditingController();
  List<Data> brtsStopList = [];
  List<Data> localBrtsStopList = [];
  String _selectedValue = '';
  String _selectedValue2 = '';
  bool _isExpanded = true;

  Future<void> _loadStoredValue() async {
    final List<String> storedValues = await SharedPreferencesHelper.getStoredValues();
    if (storedValues.isNotEmpty) {
      setState(() {
        _selectedValue = storedValues.join(', '); // Join all values into a single string
      });
    }
  }

  void _saveSelectedValue(int index) async {
    final String value = widget.selectedLanguage == "gu" ? localBrtsStopList[index].stopNameGujarati!:localBrtsStopList[index].stopName!;
    await SharedPreferencesHelper.saveValue(value);
    setState(() {
      _selectedValue = value;
    });
  }

  Future<void> _loadStoredValue2() async {
    final List<String> storedValues2 = await SharedPreferencesHelper2.getStoredValues2();
    if (storedValues2.isNotEmpty) {
      setState(() {
        _selectedValue2 = storedValues2.join(', '); // Join all values into a single string
      });
    }
  }

  void _saveSelectedValue2(int index) async {
    final String value = widget.selectedLanguage == "gu" ? localBrtsStopList[index].stopNameGujarati!:localBrtsStopList[index].stopName!;
    await SharedPreferencesHelper2.saveValue2(value);
    setState(() {
      _selectedValue2 = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadStoredValue();
    _loadStoredValue2();
    // brtsStopResponseModel = Get.arguments as BrtsStopResponseModel;
    localBrtsStopResponseModel = Get.arguments as BrtsStopResponseModel;
    brtsStopList = localBrtsStopResponseModel?.data ?? [];
    localBrtsStopList = localBrtsStopResponseModel?.data ?? [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.profileBackgroundGrey,
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: Dimensions.dp25),
            const CustomToolbar(
              title: "search_stop",
              showOption: false,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: Dimensions.dp24,
                right: Dimensions.dp24,
                top: Dimensions.dp26,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller,
                    onChanged: (value) {
                      _isExpanded = false;
                      filterData(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      suffixIcon: controller.text.isEmpty
                          ? Icon(
                        Icons.search,
                        size: 20,
                        color:  Theme.of(context).primaryColor,
                      )
                          : InkWell(
                        onTap: () {
                          controller.text = '';
                          filterData(controller.text);
                        },
                        child: Icon(
                          Icons.cancel,
                          size: 20,
                          color:  Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    style: satoshiRegular.copyWith(
                        fontSize: Dimensions.dp18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGray),
                  ),
                  SizedBox(height: Dimensions.dp16),
                  controller.text.isEmpty ?
                  Column(
                    children: [
                      Text(
                        'Recent Searches',
                        style: TextStyle(
                          fontSize: Dimensions.dp14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGray,
                        ),
                      ),
                      SizedBox(height: Dimensions.dp8),
                   widget.stopType == "AMTS" ?   FutureBuilder<List<String>>(
                     future: SharedPreferencesHelper2.getStoredValues2(),
                     builder: (context, snapshot) {
                       final List<String> storedValues2 = snapshot.data ?? [];
                       final limitedValues = storedValues2.take(4).toList(); // Limit the values to a maximum of 4
                       return Column(
                         //spacing: Dimensions.dp8,
                         // runSpacing: Dimensions.dp8,
                         children: limitedValues.map((value) => GestureDetector(
                           onTap: () {
                             controller.text = value;
                             filterData(value);
                           },
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 34),
                             child: Column(
                               //  mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding:  EdgeInsets.symmetric(vertical: 20.sp),
                                   child: Text(
                                     value,
                                     style: satoshiRegular.copyWith(
                                         fontSize: Dimensions.dp18.sp,
                                         fontWeight: FontWeight.w400,
                                         color: AppColors.darkGray),
                                   ),
                                 ),
                                 const Divider(
                                   height: 1,
                                   color: AppColors.lightGray,
                                 )
                               ],
                             ),
                           ),

                         )
                         ).toList(),
                       );
                     },
                   ) :  FutureBuilder<List<String>>(
                        future: SharedPreferencesHelper.getStoredValues(),
                        builder: (context, snapshot) {
                          final List<String> storedValues = snapshot.data ?? [];
                          final limitedValues = storedValues.take(4).toList(); // Limit the values to a maximum of 4
                          return Column(
                            //spacing: Dimensions.dp8,
                            // runSpacing: Dimensions.dp8,
                            children: limitedValues.map((value) => GestureDetector(
                              onTap: () {
                                controller.text = value;
                                filterData(value);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 34),
                                child: Column(
                                  //  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.symmetric(vertical: 20.sp),
                                      child: Text(
                                        value,
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp18.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.darkGray),
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: AppColors.lightGray,
                                    )
                                  ],
                                ),
                              ),

                            )
                            ).toList(),
                          );
                        },
                      ),
                    ],
                  ) : SizedBox(height: 0,)


                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            const Divider(
              height: 1,
              color: AppColors.lightGray,
            ),
            controller.text.isNotEmpty ?
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                itemCount: localBrtsStopList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(widget.selectedLanguage == "gu"
                            ?localBrtsStopList[index].stopNameGujarati??"":
                          localBrtsStopList[index].stopName ?? "",
                          style: satoshiRegular.copyWith(
                              fontSize: Dimensions.dp18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGray),
                        ),
                        onTap: () {
                         widget.stopType == "AMTS" ?  _saveSelectedValue2(index) : _saveSelectedValue(index);
                          Get.back(result: localBrtsStopList[index]);
                        },
                      ),
                      const Divider(
                        height: 1,
                        color: AppColors.lightGray,
                      )
                    ],
                  );
                },
              ),
            ) : SizedBox(height: 0,)
          ],
        ),
      ),
    );
  }

  filterData(String value){
    localBrtsStopList = brtsStopList.where((element) {
      return element.stopName
          ?.toLowerCase()
          .contains(value.toLowerCase()) ??
          false;
    }).toList();
    setState(() {});
  }
}

class SharedPreferencesHelper {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const String _keyStoredValues = 'storedValues';

  static Future<List<String>> getStoredValues() async {
    final SharedPreferences prefs = await _prefs;
    final List<String> storedValues = prefs.getStringList(_keyStoredValues) ?? [];
    return storedValues;
  }

  static Future<void> saveValue(String value) async {
    final SharedPreferences prefs = await _prefs;
    List<String> storedValues = prefs.getStringList(_keyStoredValues) ?? [];

    if (storedValues.contains(value)) {
      storedValues.remove(value);
    }

    storedValues.insert(0, value);

    if (storedValues.length > 4) {
      storedValues = storedValues.sublist(0, 4);
    }

    await prefs.setStringList(_keyStoredValues, storedValues);
  }
}

class SharedPreferencesHelper2 {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const String _keyStoredValues2 = 'storedValues2';

  static Future<List<String>> getStoredValues2() async {
    final SharedPreferences prefs2 = await _prefs;
    final List<String> storedValues2 = prefs2.getStringList(_keyStoredValues2) ?? [];
    return storedValues2;
  }

  static Future<void> saveValue2(String value) async {
    final SharedPreferences prefs = await _prefs;
    List<String> storedValues2 = prefs.getStringList(_keyStoredValues2) ?? [];

    if (storedValues2.contains(value)) {
      storedValues2.remove(value);
    }

    storedValues2.insert(0, value);

    if (storedValues2.length > 4) {
      storedValues2 = storedValues2.sublist(0, 4);
    }

    await prefs.setStringList(_keyStoredValues2, storedValues2);
  }
}
