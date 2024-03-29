import 'package:hive/hive.dart';
part 'brts_stop_respons_model.g.dart';

@HiveType(typeId: 1)
class BrtsStopResponseModel extends HiveObject {
  BrtsStopResponseModel({
      List<DataHive>? data,
      bool? succeeded,}){
    data = data;
    _succeeded = succeeded;
}

  BrtsStopResponseModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataHive.fromJson(v));
      });
    }
    _succeeded = json['succeeded'];
  }
  @HiveField(0)
  List<DataHive>? data;
  @HiveField(1)
  bool? _succeeded;
BrtsStopResponseModel copyWith({  List<DataHive>? data,
  bool? succeeded,
}) => BrtsStopResponseModel(  data: data ?? this.data,
  succeeded: succeeded ?? _succeeded,
);
  // List<Data>? get data => _data;
  bool? get succeeded => _succeeded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['succeeded'] = _succeeded;
    return map;
  }

}

/// stationCode : "29"
/// stopName : "Maninagar"
/// stopNameGujarati : "મણિનગર"
@HiveType(typeId: 2)
class DataHive extends HiveObject{
  DataHive({
      String? stationCode, 
      String? stopName, 
      String? stopNameGujarati,}){
    _stationCode = stationCode;
    _stopName = stopName;
    _stopNameGujarati = stopNameGujarati;
}

  DataHive.fromJson(dynamic json) {
    _stationCode = json['stationCode'];
    _stopName = json['stopName'];
    _stopNameGujarati = json['stopNameGujarati'];
  }
  @HiveField(0)
  String? _stationCode;
  @HiveField(1)
  String? _stopName;
  @HiveField(2)
  String? _stopNameGujarati;
DataHive copyWith({  String? stationCode,
  String? stopName,
  String? stopNameGujarati,
}) => DataHive(  stationCode: stationCode ?? _stationCode,
  stopName: stopName ?? _stopName,
  stopNameGujarati: stopNameGujarati ?? _stopNameGujarati,
);
  String? get stationCode => _stationCode;
  String? get stopName => _stopName;
  String? get stopNameGujarati => _stopNameGujarati;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stationCode'] = _stationCode;
    map['stopName'] = _stopName;
    map['stopNameGujarati'] = _stopNameGujarati;
    return map;
  }

}