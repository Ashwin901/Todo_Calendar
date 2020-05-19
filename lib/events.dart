import 'package:irisblocpattern/map_tasks.dart';

class TaskEvent{}

class AddTaskEvent extends TaskEvent{
  MapTasks addTasks;
  Map<DateTime, List<dynamic>> newTasks;
  AddTaskEvent({this.addTasks,this.newTasks});
}

class GetTaskEvent extends TaskEvent{}

class DisplayEvent extends TaskEvent{
  var box;
  DisplayEvent({this.box});
}

class GetSelectedEvents extends TaskEvent{
  List<dynamic> selectedTasks;
  GetSelectedEvents({this.selectedTasks});
}

class CheckEvent extends TaskEvent{
  dynamic task;
  bool newValue;
  DateTime date;
  Map<DateTime, List<dynamic>> reTasks;
  CheckEvent({this.task,this.newValue,this.date,this.reTasks});
}

class DeleteEvent extends TaskEvent{
  DateTime date;
  dynamic deletedTask;
  Map<DateTime, List<dynamic>> updatedTasks;
  DeleteEvent({this.date,this.deletedTask,this.updatedTasks});
}

