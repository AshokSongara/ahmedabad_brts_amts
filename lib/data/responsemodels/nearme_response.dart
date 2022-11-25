class NearMeResponse {
  int? statusCode;
  List<Nearme>? nearme;

  NearMeResponse({this.statusCode, this.nearme});

  NearMeResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['nearme'] != null) {
      nearme = <Nearme>[];
      json['nearme'].forEach((v) {
        nearme!.add(new Nearme.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.nearme != null) {
      data['nearme'] = this.nearme!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nearme {
  String? stationCode;
  String? stopCode;
  String? stopName;
  String? stopNameGujarati;
  double? latitude;
  double? longitude;
  double? distance;
  int? statusCode;

  Nearme(
      {this.stationCode,
        this.stopCode,
        this.stopName,
        this.stopNameGujarati,
        this.latitude,
        this.longitude,
        this.distance,
        this.statusCode});

  Nearme.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationCode'] = this.stationCode;
    data['stopCode'] = this.stopCode;
    data['stopName'] = this.stopName;
    data['stopNameGujarati'] = this.stopNameGujarati;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    data['statusCode'] = this.statusCode;
    return data;
  }
}