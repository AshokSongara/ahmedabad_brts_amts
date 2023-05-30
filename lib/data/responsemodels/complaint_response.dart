class ComplaintResponseModel {
  ComplaintResponseModel({
    this.data,
    this.succeeded,});

  ComplaintResponseModel.fromJson(dynamic json) {
    data = json['data'];
    succeeded = json['succeeded'];
  }
  int? data;
  bool? succeeded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['succeeded'] = succeeded;
    return map;
  }

}