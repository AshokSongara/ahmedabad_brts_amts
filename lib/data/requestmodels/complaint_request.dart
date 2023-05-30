class ComplaintRequest {
  String? title;
  String? date;
  String? time;
  int? category;
  int? subCategory;
  String? busNo;
  String? stationId;
  String? route;
  String? landmark;
  String? description;
  String? mobile;
  int? severnity;

  ComplaintRequest({this.title, this.date,this.time, this.category, this.subCategory, this.busNo, this.stationId, this.route, this.landmark, this.description, this.mobile, this.severnity});
}
