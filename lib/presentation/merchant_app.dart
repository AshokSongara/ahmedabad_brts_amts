import 'package:flutter/material.dart';
import 'dart:io';
import '../data/requestmodels/json_request.dart';

class MerchantApp extends StatefulWidget {
  const MerchantApp({super.key});

  @override
  State<MerchantApp> createState() => MerchantScreen();
}

class MerchantScreen extends State<MerchantApp> {
  PhonepeRequest phonepeRequest = PhonepeRequest(
      startStopCode: "101",
      endStopCode: "104",
      discountype: "01",
      routeCode: "11U",
      routeType: 1,
      mobileNumber: "9876543210",
      deviceOS: "IOS",
      paymentInstrumentType: "UPI_INTENT",
      targateApp: "com.phonepe.simulator");


  String body = "";
  String callback = "103.69.196.78:8082/PhonepePG/PayRequest";
  String checksum = "";

  Map<String, String> headers = {};
  Map<String, String> pgHeaders = {"Content-Type": "application/json"};
  List<String> apiList = <String>['Container', 'PG'];
  List<String> environmentList = <String>['UAT', 'UAT_SIM', 'PRODUCTION'];
  String apiEndPoint = "/pg/v1/pay";
  bool enableLogs = true;
  Object? result;
  String dropdownValue = 'PG';
  String environmentValue = 'UAT_SIM';
  String appId = "";
  String merchantId = "";
  String packageName = "com.phonepe.simulator";

  void handleError(error) {
    setState(() {
      if (error is Exception) {
        result = error.toString();
      } else {
        result = {"error": error};
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Merchant Demo App'),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(7),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Merchant Id',
                    ),
                    onChanged: (text) {
                      merchantId = text;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'App Id',
                    ),
                    onChanged: (text) {
                      appId = text;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text('Select the environment'),
                      DropdownButton<String>(
                        value: environmentValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            environmentValue = value!;
                            if (environmentValue == 'PRODUCTION') {
                              packageName = "com.phonepe.app";
                            } else if (environmentValue == 'UAT') {
                              packageName = "com.phonepe.app.preprod";
                            } else if (environmentValue == 'UAT_SIM') {
                              packageName = "com.phonepe.simulator";
                            }
                          });
                        },
                        items: environmentList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Visibility(
                      maintainSize: false,
                      maintainAnimation: false,
                      maintainState: false,
                      visible: Platform.isAndroid,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Text("Package Name: $packageName"),
                          ])),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: enableLogs,
                          onChanged: (state) {
                            setState(() {
                              enableLogs = state!;
                            });
                          }),
                      const Text("Enable Logs")
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Warning: Init SDK is Mandatory to use all the functionalities*',
                    style: TextStyle(color: Colors.red),
                  ),

                  const SizedBox(width: 5.0),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'body',
                    ),
                    onChanged: (text) {
                      body = text;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'checksum',
                    ),
                    onChanged: (text) {
                      checksum = text;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text('Select the transaction type'),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                            if (dropdownValue == 'PG') {
                              apiEndPoint = "/pg/v1/pay";
                            } else {
                              apiEndPoint = "/v4/debit";
                            }
                          });
                        },
                        items: apiList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}