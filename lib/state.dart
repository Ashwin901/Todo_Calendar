class TaskState{}

class InitState extends TaskState{}

class AddTaskState extends TaskState{
  Map<DateTime, List<dynamic>> addedTasks;
  AddTaskState({this.addedTasks});
}

class GetTaskState extends TaskState{
  var box;
  GetTaskState({this.box});
}

class DisplayState extends TaskState{
  Map<DateTime, List<dynamic>> tasks;
  DisplayState({this.tasks});
}

class GetSelectedState extends TaskState{
  List<dynamic> tasks;
  GetSelectedState({this.tasks});
}

class CheckTaskState extends TaskState{
  Map<DateTime, List<dynamic>> tasks;
  CheckTaskState({this.tasks});
}

class DeleteTaskState extends TaskState{
  Map<DateTime, List<dynamic>> updatedTasks;
  DeleteTaskState({this.updatedTasks});
}

