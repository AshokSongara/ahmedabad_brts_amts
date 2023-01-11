class ETAResponse {
  List<Data>? data;
  bool? succeeded;

  ETAResponse({this.data, this.succeeded});

  ETAResponse.fromJson(Map<String, dynamic> json) {
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
  String? eta;
  String? stopCode;
  String? routeCode;

  Data({this.eta, this.stopCode, this.routeCode});

  Data.fromJson(Map<String, dynamic> json) {
    eta = json['eta'];
    stopCode = json['stopCode'];
    routeCode = json['routeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eta'] = this.eta;
    data['stopCode'] = this.stopCode;
    data['routeCode'] = this.routeCode;
    return data;
  }
}