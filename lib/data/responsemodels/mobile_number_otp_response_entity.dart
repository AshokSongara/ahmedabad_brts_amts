class MobileNumberOtpResponseEntity {
  MobileNumberOtpResponseEntity({bool? statusCode}) {
    _statusCode = statusCode;
  }

  MobileNumberOtpResponseEntity.fromJson(dynamic json) {
    _statusCode = json['succeeded'];
  }

  bool? _statusCode;

  MobileNumberOtpResponseEntity copyWith({
    bool? statusCode,
  }) =>
      MobileNumberOtpResponseEntity(
        statusCode: statusCode ?? _statusCode,
      );

  bool? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['succeeded'] = _statusCode;
    return map;
  }
}
