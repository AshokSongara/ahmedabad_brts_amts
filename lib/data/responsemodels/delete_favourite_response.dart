class DeleteFavouriteResponse {
  bool? succeeded;

  DeleteFavouriteResponse({this.succeeded});

  DeleteFavouriteResponse.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['succeeded'] = this.succeeded;
    return data;
  }
}
