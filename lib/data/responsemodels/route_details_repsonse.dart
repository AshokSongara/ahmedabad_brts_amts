class RouteDetailsRepsonse {
  List<DataRoute>? data;
  bool? succeeded;

  RouteDetailsRepsonse({this.data, this.succeeded});

  RouteDetailsRepsonse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataRoute>[];
      json['data'].forEach((v) {
        data!.add(DataRoute.fromJson(v));
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

class DataRoute {
  String? stopCode;
  int? sequenceNumber;
  String? stopName;
  String? stopNameGujarati;

  DataRoute(
      {this.stopCode,
      this.sequenceNumber,
      this.stopName,
      this.stopNameGujarati});

  DataRoute.fromJson(Map<String, dynamic> json) {
    stopCode = json['stopCode'];
    sequenceNumber = json['sequenceNumber'];
    stopName = json['stopName'];
    stopNameGujarati = json['stopNameGujarati'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stopCode'] = stopCode;
    data['sequenceNumber'] = sequenceNumber;
    data['stopName'] = stopName;
    data['stopNameGujarati'] = stopNameGujarati;
    return data;
  }
}