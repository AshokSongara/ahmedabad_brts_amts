class NearMeResponse {
  List<Data>? data;
  bool? succeeded;

  NearMeResponse({this.data, this.succeeded});

  NearMeResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['succeeded'] = succeeded;
    return data;
  }
}

class Data {
  String? stationCode;
  String? stopCode;
  String? stopName;
  String? stopNameGujarati;
  double? latitude;
  double? longitude;
  double? distance;
  int? statusCode;

  Data(
      {this.stationCode,
        this.stopCode,
        this.stopName,
        this.stopNameGujarati,
        this.latitude,
        this.longitude,
        this.distance,
        this.statusCode});

  Data.fromJson(Map<String, dynamic> json) {
    stationCode = json['stationCode'];
    stopCode = json['stopCode'];
    stopName = json['stopName'];
    stopNameGujarati = json['stopNameGujarati'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stationCode'] = stationCode;
    data['stopCode'] = stopCode;
    data['stopName'] = stopName;
    data['stopNameGujarati'] = stopNameGujarati;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['distance'] = distance;
    data['statusCode'] = statusCode;
    return data;
  }
}