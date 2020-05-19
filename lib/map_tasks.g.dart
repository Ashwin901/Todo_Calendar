// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_tasks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MapTasksAdapter extends TypeAdapter<MapTasks> {
  @override
  final typeId = 0;

  @override
  MapTasks read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MapTasks(
      eventsDate: fields[0] as DateTime,
      events: (fields[1] as List)?.cast<TaskElements>(),
    );
  }

  @override
  void write(BinaryWriter writer, MapTasks obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.eventsDate)
      ..writeByte(1)
      ..write(obj.events);
  }
}
