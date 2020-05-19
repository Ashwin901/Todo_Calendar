import 'package:hive/hive.dart';
import 'task_elements.dart';
part 'map_tasks.g.dart';
@HiveType(typeId: 0)
class MapTasks{
  @HiveField(0)
  DateTime eventsDate;
  @HiveField(1)
  List<TaskElements>events;
  MapTasks({this.eventsDate,this.events});
}