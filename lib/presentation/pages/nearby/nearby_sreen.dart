import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:flutter/material.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({Key? key}) : super(key: key);

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      Stack(children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            color: AppColors.primaryColor,
          ),
        ),
      ]),);
  }
}
