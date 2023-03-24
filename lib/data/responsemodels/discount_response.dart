class DiscountResponse {
  List<Data>? data;
  bool? succeeded;

  DiscountResponse({this.data, this.succeeded});

  DiscountResponse.fromJson(Map<String, dynamic> json) {
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
  String? discountTypeCode;
  String? catPassSubCateName;
  String? mediaType;
  String? operator;
  int? discountRate;
  Null? passFare;

  Data(
      {this.discountTypeCode,
      this.catPassSubCateName,
      this.mediaType,
      this.operator,
      this.discountRate,
      this.passFare});

  Data.fromJson(Map<String, dynamic> json) {
    discountTypeCode = json['discountTypeCode'];
    catPassSubCateName = json['catPassSubCateName'];
    mediaType = json['mediaType'];
    operator = json['operator'];
    discountRate = json['discountRate'];
    passFare = json['passFare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discountTypeCode'] = this.discountTypeCode;
    data['catPassSubCateName'] = this.catPassSubCateName;
    data['mediaType'] = this.mediaType;
    data['operator'] = this.operator;
    data['discountRate'] = this.discountRate;
    data['passFare'] = this.passFare;
    return data;
  }
}