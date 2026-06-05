// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: (fields[0] as num).toInt(),
      taskTime: fields[6] as TimeOfDay,
      taskDate: fields[5] as DateTime,
      taskName: fields[1] as String,
      isHighpreority: fields[3] as bool,
      taskDesc: fields[2] as String,
      iSDONE: fields[4] == null ? false : fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskName)
      ..writeByte(2)
      ..write(obj.taskDesc)
      ..writeByte(3)
      ..write(obj.isHighpreority)
      ..writeByte(4)
      ..write(obj.iSDONE)
      ..writeByte(5)
      ..write(obj.taskDate)
      ..writeByte(6)
      ..write(obj.taskTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
