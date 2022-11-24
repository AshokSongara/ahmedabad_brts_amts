class NearMeResponse {
  String? stationCode;
  String? stopCode;
  String? stopName;
  String? stopNameGujarati;
  double? latitude;
  double? longitude;
  double? distance;

  NearMeResponse(
      {this.stationCode,
        this.stopCode,
        this.stopName,
        this.stopNameGujarati,
        this.latitude,
        this.longitude,
        this.distance});

  NearMeResponse.fromJson(Map<String, dynamic> json) {
    stationCode = json['stationCode'];
    stopCode = json['stopCode'];
    stopName = json['stopName'];
    stopNameGujarati = json['stopNameGujarati'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
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
    return data;
  }
}