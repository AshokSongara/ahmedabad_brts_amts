class QRCodeResponse {
  List<Data>? data;
  bool? succeeded;

  QRCodeResponse({this.data, this.succeeded});

  QRCodeResponse.fromJson(Map<String, dynamic> json) {
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
  String? datetime;
  String? ticketnumber;
  String? qrcode;

  Data({this.datetime, this.ticketnumber, this.qrcode});

  Data.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    ticketnumber = json['ticketnumber'];
    qrcode = json['qrcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datetime'] = this.datetime;
    data['ticketnumber'] = this.ticketnumber;
    data['qrcode'] = this.qrcode;
    return data;
  }
}