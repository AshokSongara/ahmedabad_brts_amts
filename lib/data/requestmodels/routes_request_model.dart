/// stopType : 2

class RoutesRequestModel {
  RoutesRequestModel({
      int? stopType,}){
    _stopType = stopType;
}

  RoutesRequestModel.fromJson(dynamic json) {
    _stopType = json['stopType'];
  }
  int? _stopType;
RoutesRequestModel copyWith({  int? stopType,
}) => RoutesRequestModel(  stopType: stopType ?? _stopType,
);
  int? get stopType => _stopType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stopType'] = _stopType;
    return map;
  }

}