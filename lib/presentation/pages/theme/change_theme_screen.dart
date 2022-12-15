import 'package:ahmedabad_brts_amts/core/theme/theme_service.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangeThemeScreen extends StatefulWidget {
  const ChangeThemeScreen({Key? key}) : super(key: key);

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          SizedBox(height: Dimensions.dp25.h),
          CustomToolbar(
            title: "Change Theme",
            showOption: false,
          ),
          SizedBox(height: Dimensions.dp50.h),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: context.theme.buttonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  textStyle:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: (){
                  // ThemeService().switchTheme
                },
                child: const Text('Click To Change Theme')),
          ),
        ],
      ),
    );
  }
}
