/// stopType : 2

class StopRequestModel {
  StopRequestModel({
      int? stopType,}){
    _stopType = stopType;
}

  StopRequestModel.fromJson(dynamic json) {
    _stopType = json['stopType'];
  }
  int? _stopType;
StopRequestModel copyWith({  int? stopType,
}) => StopRequestModel(  stopType: stopType ?? _stopType,
);
  int? get stopType => _stopType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stopType'] = _stopType;
    return map;
  }

}