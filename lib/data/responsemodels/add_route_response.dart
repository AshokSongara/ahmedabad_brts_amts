class AddRouteResponse {
  int? data;
  bool? succeeded;

  AddRouteResponse({this.data, this.succeeded});

  AddRouteResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.data;
    data['succeeded'] = succeeded;
    return data;
  }
}