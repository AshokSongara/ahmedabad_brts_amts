class RouteDetailsRepsonse {
  List<Data>? data;
  bool? succeeded;

  RouteDetailsRepsonse({this.data, this.succeeded});

  RouteDetailsRepsonse.fromJson(Map<String, dynamic> json) {
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
  String? stopCode;
  int? sequenceNumber;
  String? stopName;
  String? stopNameGujarati;

  Data(
      {this.stopCode,
      this.sequenceNumber,
      this.stopName,
      this.stopNameGujarati});

  Data.fromJson(Map<String, dynamic> json) {
    stopCode = json['stopCode'];
    sequenceNumber = json['sequenceNumber'];
    stopName = json['stopName'];
    stopNameGujarati = json['stopNameGujarati'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stopCode'] = this.stopCode;
    data['sequenceNumber'] = this.sequenceNumber;
    data['stopName'] = this.stopName;
    data['stopNameGujarati'] = this.stopNameGujarati;
    return data;
  }
}