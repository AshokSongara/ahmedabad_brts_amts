// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brts_routes_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrtsRoutesResponseModelAdapter
    extends TypeAdapter<BrtsRoutesResponseModel> {
  @override
  final int typeId = 3;

  @override
  BrtsRoutesResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrtsRoutesResponseModel()
      .._data = (fields[0] as List?)?.cast<RouteData>()
      .._succeeded = fields[1] as bool?;
  }

  @override
  void write(BinaryWriter writer, BrtsRoutesResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._data)
      ..writeByte(1)
      ..write(obj._succeeded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrtsRoutesResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RouteDataAdapter extends TypeAdapter<RouteData> {
  @override
  final int typeId = 4;

  @override
  RouteData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RouteData()
      .._routeCode = fields[0] as String?
      .._customerRouteCode = fields[1] as String?
      .._lineCode = fields[2] as String?
      .._routeName = fields[3] as String?
      .._routeNameGujarati = fields[4] as String?
      .._routeDestination = fields[5] as String?
      .._routeDestinationGujarati = fields[6] as String?
      .._routeVariant = fields[7] as String?
      .._routeVariantGujarati = fields[8] as String?
      ..isFav = fields[9] as bool;
  }

  @override
  void write(BinaryWriter writer, RouteData obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj._routeCode)
      ..writeByte(1)
      ..write(obj._customerRouteCode)
      ..writeByte(2)
      ..write(obj._lineCode)
      ..writeByte(3)
      ..write(obj._routeName)
      ..writeByte(4)
      ..write(obj._routeNameGujarati)
      ..writeByte(5)
      ..write(obj._routeDestination)
      ..writeByte(6)
      ..write(obj._routeDestinationGujarati)
      ..writeByte(7)
      ..write(obj._routeVariant)
      ..writeByte(8)
      ..write(obj._routeVariantGujarati)
      ..writeByte(9)
      ..write(obj.isFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
