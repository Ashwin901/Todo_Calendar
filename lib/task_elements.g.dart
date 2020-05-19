// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_elements.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskElementsAdapter extends TypeAdapter<TaskElements> {
  @override
  final typeId = 1;

  @override
  TaskElements read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskElements(
      boxTasks: fields[0] as dynamic,
      isChecked: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskElements obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.boxTasks)
      ..writeByte(1)
      ..write(obj.isChecked);
  }
}
