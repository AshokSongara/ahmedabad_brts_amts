import 'package:hive_flutter/adapters.dart';
part 'brts_routes_response_model.g.dart';

@HiveType(typeId: 3)
class BrtsRoutesResponseModel extends HiveObject{
  BrtsRoutesResponseModel({
      List<RouteData>? data,
      bool? succeeded,}){
    _data = data;
    _succeeded = succeeded;
}

  BrtsRoutesResponseModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RouteData.fromJson(v));
      });
    }
    _succeeded = json['succeeded'];
  }
  @HiveField(0)
  List<RouteData>? _data;
  @HiveField(1)
  bool? _succeeded;
BrtsRoutesResponseModel copyWith({  List<RouteData>? data,
  bool? succeeded,
}) => BrtsRoutesResponseModel(  data: data ?? _data,
  succeeded: succeeded ?? _succeeded,
);
  List<RouteData>? get data => _data;
  bool? get succeeded => _succeeded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['succeeded'] = _succeeded;
    return map;
  }

}

@HiveType(typeId: 4)
class RouteData extends HiveObject{
  RouteData({
      String? routeCode, 
      String? customerRouteCode, 
      String? lineCode, 
      String? routeName,
    String? routeNameGujarati,
      String? routeDestination,
    String? routeDestinationGujarati,
      String? routeVariant,
    String? routeVariantGujarati,}){
    _routeCode = routeCode;
    _customerRouteCode = customerRouteCode;
    _lineCode = lineCode;
    _routeName = routeName;
    _routeNameGujarati = routeNameGujarati;
    _routeDestination = routeDestination;
    _routeDestinationGujarati = routeDestinationGujarati;
    _routeVariant = routeVariant;
    _routeVariantGujarati = routeVariantGujarati;
}

  RouteData.fromJson(dynamic json) {
    _routeCode = json['routeCode'];
    _customerRouteCode = json['customerRouteCode'];
    _lineCode = json['lineCode'];
    _routeName = json['routeName'];
    _routeNameGujarati = json['routeNameGujarati'];
    _routeDestination = json['routeDestination'];
    _routeDestinationGujarati = json['routeDestinationGujarati'];
    _routeVariant = json['routeVariant'];
    _routeVariantGujarati = json['routeVariantGujarati'];
  }
  @HiveField(0)
  String? _routeCode;
  @HiveField(1)
  String? _customerRouteCode;
  @HiveField(2)
  String? _lineCode;
  @HiveField(3)
  String? _routeName;
  @HiveField(4)
  String? _routeNameGujarati;
  @HiveField(5)
  String? _routeDestination;
  @HiveField(6)
  String? _routeDestinationGujarati;
  @HiveField(7)
  String? _routeVariant;
  @HiveField(8)
  String? _routeVariantGujarati;
  @HiveField(9)
  bool? isFav = false;
  setFav(bool? isFav){
    this.isFav =isFav;
  }
RouteData copyWith({  String? routeCode,
  String? customerRouteCode,
  String? lineCode,
  String? routeName,
  String? routeNameGujarati,
  String? routeDestination,
  String? routeDestinationGujarati,
  String? routeVariant,
  String? routeVariantGujarati,
}) => RouteData(  routeCode: routeCode ?? _routeCode,
  customerRouteCode: customerRouteCode ?? _customerRouteCode,
  lineCode: lineCode ?? _lineCode,
  routeName: routeName ?? _routeName,
  routeNameGujarati: routeNameGujarati ?? _routeNameGujarati,
  routeDestination: routeDestination ?? _routeDestination,
  routeDestinationGujarati: routeDestinationGujarati ?? _routeDestinationGujarati,
  routeVariant: routeVariant ?? _routeVariant,
  routeVariantGujarati: routeVariantGujarati ?? _routeVariantGujarati,
);
  String? get routeCode => _routeCode;
  String? get customerRouteCode => _customerRouteCode;
  String? get lineCode => _lineCode;
  String? get routeName => _routeName;
  String? get routeNameGujarati => _routeNameGujarati;
  String? get routeDestination => _routeDestination;
  String? get routeDestinationGujarati => _routeDestinationGujarati;
  String? get routeVariant => _routeVariant;
  String? get routeVariantGujarati => _routeVariantGujarati;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['routeCode'] = _routeCode;
    map['customerRouteCode'] = _customerRouteCode;
    map['lineCode'] = _lineCode;
    map['routeName'] = _routeName;
    map['routeNameGujarati'] = _routeNameGujarati;
    map['routeDestination'] = _routeDestination;
    map['routeDestinationGujarati'] = _routeDestinationGujarati;
    map['routeVariant'] = _routeVariant;
    map['routeVariantGujarati'] = _routeVariantGujarati;
    return map;
  }

}