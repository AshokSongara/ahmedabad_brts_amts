class FavouriteRoutesResponseList {
  List<Data>? data;
  bool? succeeded;

  FavouriteRoutesResponseList({this.data, this.succeeded});

  FavouriteRoutesResponseList.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? routeId;
  String? routeLongName;

  Data({this.id, this.routeId, this.routeLongName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['routeId'];
    routeLongName = json['routeLongName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['routeId'] = this.routeId;
    data['routeLongName'] = this.routeLongName;
    return data;
  }
}