import 'dart:math';

import 'package:intl/intl.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

double roundDouble(double? value, int places) {
  num mod = pow(10.0, places);
  return ((value! * mod).round().toDouble() / mod);
}

String getDateTime(String dateTimeData) {
  var dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(dateTimeData, true);
  var dateLocal = dateTime.toLocal();
  return dateLocal.toString();
}

String getDistanceInMeters(String distance){
  double convertedDistance = double.parse((double.parse(distance)).toStringAsFixed(2));
  return "${convertedDistance} Mtrs";
}
