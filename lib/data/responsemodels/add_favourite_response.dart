class AddFavouriteResponse {
  int? data;
  bool? succeeded;

  AddFavouriteResponse({this.data, this.succeeded});

  AddFavouriteResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['succeeded'] = this.succeeded;
    return data;
  }
}