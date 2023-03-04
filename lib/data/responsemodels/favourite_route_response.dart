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

  Data(
      {this.id,
        this.startStopId,
        this.startStop,
        this.endStopId,
        this.endStop,
        this.favouriteRoute});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startStopId = json['startStopId'];
    startStop = json['startStop'];
    endStopId = json['endStopId'];
    endStop = json['endStop'];
    favouriteRoute = json['favouriteRoute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['startStopId'] = startStopId;
    data['startStop'] = startStop;
    data['endStopId'] = endStopId;
    data['endStop'] = endStop;
    data['favouriteRoute'] = favouriteRoute;
    return data;
  }
}