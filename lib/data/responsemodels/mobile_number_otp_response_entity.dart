/// statusCode : 200
/// id : 2

class MobileNumberOtpResponseEntity {
  MobileNumberOtpResponseEntity({
      int? statusCode, 
      int? id,}){
    _statusCode = statusCode;
    _id = id;
}

  MobileNumberOtpResponseEntity.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _id = json['id'];
  }
  int? _statusCode;
  int? _id;
MobileNumberOtpResponseEntity copyWith({  int? statusCode,
  int? id,
}) => MobileNumberOtpResponseEntity(  statusCode: statusCode ?? _statusCode,
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