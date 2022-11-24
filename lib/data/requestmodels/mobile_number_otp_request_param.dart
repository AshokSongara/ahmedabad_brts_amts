class MobileNumberOtpRequestParam {
  MobileNumberOtpRequestParam({
      String? phoneNumber,}){
    _phoneNumber = phoneNumber;
}

  MobileNumberOtpRequestParam.fromJson(dynamic json) {
    _phoneNumber = json['phoneNumber'];
  }
  String? _phoneNumber;
MobileNumberOtpRequestParam copyWith({  String? phoneNumber,
}) => MobileNumberOtpRequestParam(  phoneNumber: phoneNumber ?? _phoneNumber,
);
  String? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _phoneNumber;
    return map;
  }

}