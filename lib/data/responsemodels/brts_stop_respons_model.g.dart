// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brts_stop_respons_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrtsStopResponseModelAdapter extends TypeAdapter<BrtsStopResponseModel> {
  @override
  final int typeId = 1;

  @override
  BrtsStopResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrtsStopResponseModel(
      data: (fields[0] as List?)?.cast<Data>(),
    ).._succeeded = fields[1] as bool?;
  }

  @override
  void write(BinaryWriter writer, BrtsStopResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj._succeeded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrtsStopResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 2;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data()
      .._stationCode = fields[0] as String?
      .._stopName = fields[1] as String?
      .._stopNameGujarati = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._stationCode)
      ..writeByte(1)
      ..write(obj._stopName)
      ..writeByte(2)
      ..write(obj._stopNameGujarati);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
