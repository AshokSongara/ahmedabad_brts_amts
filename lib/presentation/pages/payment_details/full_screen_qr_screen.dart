import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:screen_brightness/screen_brightness.dart';

class FullScreenQr extends StatefulWidget {
  final String qrCode;

  const FullScreenQr({Key? key, required this.qrCode}) : super(key: key);

  @override
  State<FullScreenQr> createState() => _FullScreenQrState();
}

class _FullScreenQrState extends State<FullScreenQr> {
  @override
  void initState() {
    super.initState();
    ScreenBrightness().setScreenBrightness(1.0);
    disableScreenshot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:  GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.black,
            child: GridView.count(
              crossAxisCount: 3,
              //padding: EdgeInsets.all(16.0),
              children: List.generate(15, (index) {
                return Center(
                  child: Image.memory(
                    base64Decode(widget.qrCode),
                    fit: BoxFit.contain,
                  ),
                );
              }),
            ),
          ),)
    );
  }

  @override
  void dispose() {
    ScreenBrightness().resetScreenBrightness();
    //disposeDisableScreenshot();
    super.dispose();
  }
}

disableScreenshot() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

disposeDisableScreenshot() async {
  await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
}
