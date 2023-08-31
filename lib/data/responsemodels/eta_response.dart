class ETAResponse {
  List<EtaData>? data;
  bool? succeeded;

  ETAResponse({this.data, this.succeeded});

  ETAResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EtaData>[];
      json['data'].forEach((v) {
        data!.add(EtaData.fromJson(v));
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

class EtaData {
  String? eta;
  String? stopCode;
  String? routeCode;

  EtaData({this.eta, this.stopCode, this.routeCode});

  EtaData.fromJson(Map<String, dynamic> json) {
    eta = json['eta'];
    stopCode = json['stopCode'];
    routeCode = json['routeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['eta'] = eta;
    data['stopCode'] = stopCode;
    data['routeCode'] = routeCode;
    return data;
  }
}