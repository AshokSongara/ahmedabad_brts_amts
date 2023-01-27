class FareResponse {
  Data? data;
  bool? succeeded;

  FareResponse({this.data, this.succeeded});

  FareResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['succeeded'] = succeeded;
    return data;
  }
}

class Data {
  int? adult;
  int? child;
  String? startStopCode;
  String? endStopCode;
  String? routeCode;

  Data(
      {this.adult,
      this.child,
      this.startStopCode,
      this.endStopCode,
      this.routeCode});

  Data.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    child = json['child'];
    startStopCode = json['startStopCode'];
    endStopCode = json['endStopCode'];
    routeCode = json['routeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['adult'] = adult;
    data['child'] = child;
    data['startStopCode'] = startStopCode;
    data['endStopCode'] = endStopCode;
    data['routeCode'] = routeCode;
    return data;
  }
}