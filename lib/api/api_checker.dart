import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getSplashRoute());
    } else {}
  }
}
