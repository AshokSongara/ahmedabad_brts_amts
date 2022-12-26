import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/language/language_cubit.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/styles.dart';
import '../../widgets/base/custom_button.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  LanguageList? _languageList = LanguageList.gujarati;
  bool languageSelected = false;

  @override
  Widget build(BuildContext context) {
    context.read<LanguageCubit>().changeStartLang();
    _languageList = AppConstant.getLocaleType(
        AppLocalizations.of(context)?.locale.toString() ?? "");
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.appBackground,
        ),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: Dimensions.dp25),
            CustomToolbar(
              title: "choose_language",
              showOption: false,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.grayC4C$C$,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: RadioListTile<LanguageList>(
                activeColor: AppColors.gray777777,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  'ગુજરાતી',
                  style: poppinsMedium,
                ),
                value: LanguageList.gujarati,
                groupValue: _languageList,
                onChanged: (LanguageList? value) {
                  setState(() {
                    languageSelected = true;
                    _languageList = value;
                    context.read<LanguageCubit>().changeLang(context, 'gu');
                  });
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.grayC4C$C$,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: RadioListTile<LanguageList>(
                activeColor: AppColors.gray777777,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  'English',
                  style: poppinsMedium,
                ),
                value: LanguageList.english,
                groupValue: _languageList,
                onChanged: (LanguageList? value) {
                  setState(() {
                    languageSelected = true;
                    _languageList = value;
                    context.read<LanguageCubit>().changeLang(context, 'en');
                  });
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 55,
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: CustomButton(
                text: AppLocalizations.of(context)?.translate('save') ??
                    "",
                width: MediaQuery.of(context).size.width,
                onPressed: ()async {
                  if (!languageSelected) {
                    _languageList = LanguageList.english;
                    context.read<LanguageCubit>().changeLang(context, 'en');
                  }
                  String? selectedLanguage =await context.read<LanguageCubit>().getCurrentSelectedLanguage();
                  Get.back(result: selectedLanguage);
                },
                style: poppinsMedium.copyWith(
                    color: Colors.white, fontSize: 15.sp),
                height: 55,
                radius: 50,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }
}
