import 'package:hive/hive.dart';
part 'task_elements.g.dart';

@HiveType(typeId: 1)
class TaskElements{
  @HiveField(0)
  dynamic boxTasks;
  @HiveField(1)
  bool isChecked;

  TaskElements({this.boxTasks,this.isChecked=false});
}