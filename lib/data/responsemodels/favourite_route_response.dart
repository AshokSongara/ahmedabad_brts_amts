class FavouriteRouteResponse {
  List<Data>? data;
  bool? succeeded;

  FavouriteRouteResponse({this.data, this.succeeded});

  FavouriteRouteResponse.fromJson(Map<String, dynamic> json) {
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
    data['succeeded'] = this.succeeded;
    return data;
  }
}

class Data {
  int? id;
  String? routeName;
  String? routeNameGujarati;

  Data({this.id, this.routeName, this.routeNameGujarati});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeName = json['routeName'];
    routeNameGujarati = json['routeNameGujarati'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['routeName'] = this.routeName;
    data['routeNameGujarati'] = this.routeNameGujarati;
    return data;
  }
}