class RouteStopListResponse {
  List<Data>? data;
  bool? succeeded;

  RouteStopListResponse({this.data, this.succeeded});

  RouteStopListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['succeeded'] = this.succeeded;
    return data;
  }
}

class Data {
  int? sequenceNumber;
  String? stopCode;
  String? stopName;
  String? routeName;

  Data({this.sequenceNumber, this.stopCode, this.stopName, this.routeName});

  Data.fromJson(Map<String, dynamic> json) {
    sequenceNumber = json['sequenceNumber'];
    stopCode = json['stopCode'];
    stopName = json['stopName'];
    routeName = json['routeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sequenceNumber'] = this.sequenceNumber;
    data['stopCode'] = this.stopCode;
    data['stopName'] = this.stopName;
    data['routeName'] = this.routeName;
    return data;
  }
}