// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_color.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainColorAdapter extends TypeAdapter<MainColor> {
  @override
  final int typeId = 21;

  @override
  MainColor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainColor(
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MainColor obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
