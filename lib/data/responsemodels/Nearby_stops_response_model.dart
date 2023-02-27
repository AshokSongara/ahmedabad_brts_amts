class NearbyStopsResponseModel {
  NearbyStopsResponseModel({
      this.data, 
      this.succeeded,});

  NearbyStopsResponseModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    succeeded = json['succeeded'];
  }
  List<Data>? data;
  bool? succeeded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['succeeded'] = succeeded;
    return map;
  }

}
class Data {
  Data({
    this.routeId,
    this.routeShortName,
    this.routeLongName,
    this.routeColor,
    this.routeTextColor,
    this.routeDesc,
    this.arrivalTime,});

  Data.fromJson(dynamic json) {
    routeId = json['routeId'];
    routeShortName = json['routeShortName'];
    routeLongName = json['routeLongName'];
    routeColor = json['routeColor'];
    routeTextColor = json['routeTextColor'];
    routeDesc = json['routeDesc'];
    arrivalTime = json['arrivalTime'];
  }
  String? routeId;
  String? routeShortName;
  String? routeLongName;
  String? routeColor;
  String? routeTextColor;
  String? routeDesc;
  String? arrivalTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['routeId'] = routeId;
    map['routeShortName'] = routeShortName;
    map['routeLongName'] = routeLongName;
    map['routeColor'] = routeColor;
    map['routeTextColor'] = routeTextColor;
    map['routeDesc'] = routeDesc;
    map['arrivalTime'] = arrivalTime;
    return map;
  }

}