import 'package:bloc/bloc.dart';
import 'events.dart';
import 'state.dart';
import 'package:hive/hive.dart';
import 'map_tasks.dart';
import 'task_elements.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  @override
  // TODO: implement initialState
  TaskState get initialState => InitState();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    var box = Hive.box('eventList');
    // TODO: implement mapEventToState
    if (event is GetTaskEvent) {
      var getBox = box;
      yield GetTaskState(box: getBox);
    } else if (event is AddTaskEvent) {
      box.add(event.addTasks);
      Map<DateTime, List<dynamic>> newTasks = {};
      newTasks = event.newTasks;
      if (newTasks[event.addTasks.eventsDate] == null) {
        newTasks[event.addTasks.eventsDate] = event.addTasks.events;
      } else if (newTasks[event.addTasks.eventsDate] != null) {
        newTasks[event.addTasks.eventsDate].add(event.addTasks.events[0]);
      }
      yield AddTaskState(addedTasks: newTasks);
    } else if (event is GetSelectedEvents) {
      yield GetSelectedState(tasks: event.selectedTasks);
    } else if (event is DisplayEvent) {
      Map<DateTime, List<dynamic>> todo = {};
      Map<dynamic, dynamic> getMapEvents = {};
      List<dynamic> getListEvents = [];
      getMapEvents = event.box.toMap();
      getListEvents = getMapEvents.values.toList();
      for (int i = 0; i < getListEvents.length; i++) {
        if (todo[getListEvents[i].eventsDate] == null) {
          todo[getListEvents[i].eventsDate] = getListEvents[i].events;
        } else if (todo[getListEvents[i].eventsDate] != null) {
          todo[getListEvents[i].eventsDate].add(getListEvents[i].events[0]);
        }
      }
      getListEvents.clear();
      yield DisplayState(tasks: todo);
    } else if (event is CheckEvent) {
      Map<DateTime, List<dynamic>> newTasks = event.reTasks;
      for (int i = 0; i < newTasks[event.date].length; i++) {
        if (newTasks[event.date][i].boxTasks == event.task) {
          newTasks[event.date][i].isChecked = event.newValue;
        }
      }
      Map<dynamic, dynamic> getMapEvents = box.toMap();
      MapTasks updateTask;
      for (int i = 0; i < getMapEvents.length; i++) {
        updateTask = box.getAt(i);
        if (updateTask.eventsDate == event.date &&
            updateTask.events[0].boxTasks == event.task) {
          box.putAt(
              i,
              MapTasks(eventsDate: event.date, events: [
                TaskElements(boxTasks: event.task, isChecked: event.newValue)
              ]));
        }
      }
      yield CheckTaskState(tasks: newTasks);
    } else if (event is DeleteEvent) {
      MapTasks mapTasks;
      List<dynamic> taskElements;
      Map<dynamic, dynamic> getMapEvents = box.toMap();
      int length = getMapEvents.length;
      for (int i = 0; i < length; i++) {
        mapTasks = box.getAt(i);
        taskElements = mapTasks.events;
        for (int j = 0; j < taskElements.length; j++) {
          if (mapTasks.eventsDate == event.date &&
              taskElements[j].boxTasks == event.deletedTask &&
              j == 0) {
            box.deleteAt(i);
            length--;
          }
        }
      }
      Map<DateTime, List<dynamic>> newTasks = event.updatedTasks;
      for (int i = 0; i < newTasks[event.date].length; i++) {
        if (newTasks[event.date][i].boxTasks == event.deletedTask) {
          newTasks[event.date].removeAt(i);
        }
      }
      yield DeleteTaskState(updatedTasks: newTasks);
    }
  }
}
