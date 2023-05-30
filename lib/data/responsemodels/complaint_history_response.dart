class ComplaintHistoryResponse {
  List<Data>? data;
  bool? succeeded;

  ComplaintHistoryResponse({this.data, this.succeeded});

  ComplaintHistoryResponse.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? date;
  String? categoryName;
  String? subCategoryName;
  String? busNo;
  String? stationId;
  String? route;
  String? landmark;
  String? description;
  String? processDefinitionKey;
  String? complaintReferenceId;
  String? mobile;

  Data(
      {this.title,
        this.date,
        this.categoryName,
        this.subCategoryName,
        this.busNo,
        this.stationId,
        this.route,
        this.landmark,
        this.description,
        this.processDefinitionKey,
        this.complaintReferenceId,
        this.mobile});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    categoryName = json['categoryName'];
    subCategoryName = json['subCategoryName'];
    busNo = json['busNo'];
    stationId = json['stationId'];
    route = json['route'];
    landmark = json['landmark'];
    description = json['description'];
    processDefinitionKey = json['processDefinitionKey'];
    complaintReferenceId = json['complaintReferenceId'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['categoryName'] = this.categoryName;
    data['subCategoryName'] = this.subCategoryName;
    data['busNo'] = this.busNo;
    data['stationId'] = this.stationId;
    data['route'] = this.route;
    data['landmark'] = this.landmark;
    data['description'] = this.description;
    data['processDefinitionKey'] = this.processDefinitionKey;
    data['complaintReferenceId'] = this.complaintReferenceId;
    data['mobile'] = this.mobile;
    return data;
  }
}
