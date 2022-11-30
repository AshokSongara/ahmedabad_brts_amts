class StopResponseModel {
  StopResponseModel({
      int? statusCode, 
      List<Stop>? stop,}){
    _statusCode = statusCode;
    _stop = stop;
}

  StopResponseModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['stop'] != null) {
      _stop = [];
      json['stop'].forEach((v) {
        _stop?.add(Stop.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<Stop>? _stop;
StopResponseModel copyWith({  int? statusCode,
  List<Stop>? stop,
}) => StopResponseModel(  statusCode: statusCode ?? _statusCode,
  stop: stop ?? _stop,
);
  int? get statusCode => _statusCode;
  List<Stop>? get stop => _stop;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_stop != null) {
      map['stop'] = _stop?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Stop {
  Stop({
      String? stopName, 
      String? stationCode, 
      String? stopCode,}){
    _stopName = stopName;
    _stationCode = stationCode;
    _stopCode = stopCode;
}

  Stop.fromJson(dynamic json) {
    _stopName = json['stopName'];
    _stationCode = json['stationCode'];
    _stopCode = json['stopCode'];
  }
  String? _stopName;
  String? _stationCode;
  String? _stopCode;
Stop copyWith({  String? stopName,
  String? stationCode,
  String? stopCode,
}) => Stop(  stopName: stopName ?? _stopName,
  stationCode: stationCode ?? _stationCode,
  stopCode: stopCode ?? _stopCode,
);
  String? get stopName => _stopName;
  String? get stationCode => _stationCode;
  String? get stopCode => _stopCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stopName'] = _stopName;
    map['stationCode'] = _stationCode;
    map['stopCode'] = _stopCode;
    return map;
  }

}