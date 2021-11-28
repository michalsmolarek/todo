// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectedCategoryAdapter extends TypeAdapter<SelectedCategory> {
  @override
  final int typeId = 26;

  @override
  SelectedCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectedCategory(
      fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SelectedCategory obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.selectedId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
