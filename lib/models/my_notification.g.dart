// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyNotificationAdapter extends TypeAdapter<MyNotification> {
  @override
  final int typeId = 88;

  @override
  MyNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyNotification(
      fields[0] as int?,
      fields[1] as DateTime?,
      fields[2] as DateTime?,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MyNotification obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateStart)
      ..writeByte(2)
      ..write(obj.dateEnd)
      ..writeByte(3)
      ..write(obj.taskId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
