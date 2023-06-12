class RoutesOnMapResponse {
  List<Data>? data;
  bool? succeeded;

  RoutesOnMapResponse({this.data, this.succeeded});

  RoutesOnMapResponse.fromJson(Map<String, dynamic> json) {
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
  String? stopLatitude;
  String? stopLongitude;
  List<String>? latlong;

  Data(
      {this.sequenceNumber,
        this.stopCode,
        this.stopName,
        this.stopLatitude,
        this.stopLongitude,
      this.latlong});

  Data.fromJson(Map<String, dynamic> json) {
    sequenceNumber = json['sequenceNumber'];
    stopCode = json['stopCode'];
    stopName = json['stopName'];
    stopLatitude = json['stopLalitude'];
    stopLongitude = json['stopLongitude'];
    latlong = json['latlong'].cast<String>();  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sequenceNumber'] = this.sequenceNumber;
    data['stopCode'] = this.stopCode;
    data['stopName'] = this.stopName;
    data['stopLatitude'] = this.stopLatitude;
    data['stopLongitude'] = this.stopLongitude;
    data['latlong'] = this.latlong;
    return data;
  }
}