/// statusCode : 200
/// id : 3

class FeedbackResponseModel {
  FeedbackResponseModel({
      int? statusCode, 
      int? id,}){
    _statusCode = statusCode;
    _id = id;
}

  FeedbackResponseModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _id = json['id'];
  }
  int? _statusCode;
  int? _id;
FeedbackResponseModel copyWith({  int? statusCode,
  int? id,
}) => FeedbackResponseModel(  statusCode: statusCode ?? _statusCode,
  id: id ?? _id,
);
  int? get statusCode => _statusCode;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['id'] = _id;
    return map;
  }

}