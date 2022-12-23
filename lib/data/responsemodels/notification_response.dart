class NotificationResponse {
  List<Data>? data;
  bool? succeeded;

  NotificationResponse({this.data, this.succeeded});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
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
  String? detail;
  String? validity;
  String? time;

  Data({this.detail, this.validity, this.time});

  Data.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    validity = json['validity'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    data['validity'] = this.validity;
    data['time'] = this.time;
    return data;
  }
}