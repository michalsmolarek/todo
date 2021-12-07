// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_done_checker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IsDoneCheckerAdapter extends TypeAdapter<IsDoneChecker> {
  @override
  final int typeId = 27;

  @override
  IsDoneChecker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IsDoneChecker(
      fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IsDoneChecker obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsDoneCheckerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
