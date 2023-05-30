class FavouriteRouteResponse {
  List<Data>? data;
  bool? succeeded;

  FavouriteRouteResponse({this.data, this.succeeded});

  FavouriteRouteResponse.fromJson(Map<String, dynamic> json) {
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
    data['succeeded'] = succeeded;
    return data;
  }
}

class Data {
  int? id;
  String? startStopId;
  String? startStop;
  String? endStopId;
  String? endStop;
  String? favouriteRoute;
  String? startStopStationCode;
  String? endStopStationCode;

  Data(
      {this.id,
        this.startStopId,
        this.startStop,
        this.endStopId,
        this.endStop,
        this.favouriteRoute,
      this.startStopStationCode,
      this.endStopStationCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startStopId = json['startStopCode'];
    startStop = json['startStopName'];
    endStopId = json['endStopCode'];
    endStop = json['endStopName'];
    favouriteRoute = json['favouriteRoute'];
    startStopStationCode = json['startStopStationCode'];
    endStopStationCode = json['endStopStationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['startStopCode'] = startStopId;
    data['startStopName'] = startStop;
    data['endStopCode'] = endStopId;
    data['endStopName'] = endStop;
    data['favouriteRoute'] = favouriteRoute;
    data['startStopStationCode'] = startStopStationCode;
    data['endStopStationCode'] = endStopStationCode;
    return data;
  }
}