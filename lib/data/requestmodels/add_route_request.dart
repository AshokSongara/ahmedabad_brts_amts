import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';

class AddRouteRequest {
  String? routeID;
  BrtsRoutesResponseModel model;
  bool isAmts;
  String? serviceType;

  AddRouteRequest({this.routeID,required this.model,required this.isAmts, this.serviceType});
}
