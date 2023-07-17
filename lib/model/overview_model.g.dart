// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OverviewModelAdapter extends TypeAdapter<OverviewModel> {
  @override
  final int typeId = 1;

  @override
  OverviewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OverviewModel(
      id: fields[12] as int,
      image: fields[0] as String,
      isSaved: fields[11] as bool,
      price: fields[1] as int,
      bedrooms: fields[2] as int,
      size: fields[4] as int,
      description: fields[5] as String,
      zip: fields[6] as String,
      city: fields[7] as String,
      latitude: fields[8] as int,
      longitude: fields[9] as int,
      bathroom: fields[3] as int,
      createdDate: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OverviewModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.bedrooms)
      ..writeByte(3)
      ..write(obj.bathroom)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.zip)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.latitude)
      ..writeByte(9)
      ..write(obj.longitude)
      ..writeByte(10)
      ..write(obj.createdDate)
      ..writeByte(11)
      ..write(obj.isSaved)
      ..writeByte(12)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverviewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
