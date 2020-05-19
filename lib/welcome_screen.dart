import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irisblocpattern/bloc.dart';
import 'package:hive/hive.dart';
import 'package:irisblocpattern/events.dart';
import 'package:irisblocpattern/state.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'map_tasks.dart';
import 'task_elements.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

var box;
CalendarController calendarController;
TextEditingController textController;
Map<DateTime, List<dynamic>> tasks;
int count;
List<dynamic> selectedEvents;
var formatter;
void openBox() async {
  box = await Hive.openBox('eventList');
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TaskBloc taskBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tasks = {};
    calendarController = CalendarController();
    textController = TextEditingController();
    openBox();
    count = 0;
    selectedEvents = [];
    formatter = new DateFormat('yyyy-MM-dd');
  }

  void addTask(MapTasks mapTasks, Map<DateTime, List<dynamic>> previousTasks) {
    taskBloc.add(AddTaskEvent(addTasks: mapTasks, newTasks: previousTasks));
  }

  void getTasks(var box) {
    taskBloc.add(DisplayEvent(box: box));
  }

  void getSelected(List<dynamic> selectedTasks) {
    taskBloc.add(GetSelectedEvents(selectedTasks: selectedTasks));
  }

  void checkTask(dynamic task, bool newValue, DateTime date,
      Map<DateTime, List<dynamic>> reTasks) {
    taskBloc.add(CheckEvent(
        task: task, newValue: newValue, date: date, reTasks: reTasks));
  }

  void deleteTask(DateTime date, dynamic deletedTask,
      Map<DateTime, List<dynamic>> updatedTasks) {
    taskBloc.add(DeleteEvent(
        date: date, deletedTask: deletedTask, updatedTasks: updatedTasks));
  }

  @override
  Widget build(BuildContext context) {
    taskBloc = BlocProvider.of<TaskBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFfee2b3),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9b384),
        title: Text(
          'TO DO LIST',
          style: TextStyle(color: Colors.black, fontFamily: 'Pacifico'),
        ),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
          bloc: taskBloc,
          builder: (BuildContext context, TaskState state) {
            if (state is GetTaskState) {
              getTasks(state.box);
            } else if (state is AddTaskState) {
              tasks = state.addedTasks;
            } else if (state is DisplayState) {
              tasks.clear();
              tasks = state.tasks;
            } else if (state is GetSelectedState) {
              selectedEvents = state.tasks;
            }
            return Column(
              children: <Widget>[
                Container(
                  child: buildCalendar(),
                ),
                Container(
                  child: FlatButton(
                    child: Text(
                      "View Tasks",
                      style: TextStyle(
                          color: count == 0 ? Colors.black : Colors.black12,
                          fontFamily: 'Pacifico'),
                    ),
                    color: count == 0 ? Colors.orangeAccent : Colors.grey,
                    onPressed: () {
                      if (count == 0) {
                        taskBloc.add(GetTaskEvent());
                        count++;
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        color: Color(0xFFfdcb9e)),
                    child: buildTaskLayout(selectedEvents),
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.orange,
        onPressed: () {
          addTaskDialog();
          if (count == 0) {
            taskBloc.add(GetTaskEvent());
            count++;
          }
        },
      ),
    );
  }

  Widget buildCalendar() {
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontFamily: 'Pacifico'),
          weekendStyle: TextStyle(fontFamily: 'Pacifico')),
      events: tasks,
      calendarController: calendarController,
      initialSelectedDay: DateTime.now(),
      calendarStyle: CalendarStyle(
          selectedColor: Color(0xFF6886c5),
          todayColor: Colors.orange,
          weekdayStyle: TextStyle(fontFamily: 'Pacifico'),
          weekendStyle: TextStyle(fontFamily: 'Pacifico', color: Colors.red)),
      headerStyle: HeaderStyle(
        titleTextStyle:
            TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Pacifico'),
        formatButtonTextStyle: TextStyle().copyWith(
            color: Colors.black, fontSize: 15.0, fontFamily: 'Pacifico'),
        formatButtonDecoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: (date, events) {
        getSelected(events);
      },
    );
  }

  void addTaskDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Color(0xFFfee2b3),
              title: Text(
                'Add Tasks',
                style: TextStyle(fontFamily: 'Pacifico'),
              ),
              content: TextField(
                controller: textController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Enter Task'),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Submit',
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'Pacifico'),
                  ),
                  color: Colors.orange,
                  onPressed: () {
                    var getDate =
                        formatter.format(calendarController.selectedDay);
                    DateTime finalDate = DateTime.parse(getDate);
                    addTask(
                        MapTasks(eventsDate: finalDate, events: [
                          TaskElements(boxTasks: textController.text)
                        ]),
                        tasks);
                    textController.clear();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  Widget buildTaskLayout(List<dynamic> selectedEvents) {
    return ListView.builder(
        itemCount: selectedEvents.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Card(
                  color: Colors.orangeAccent,
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 5.0, top: 5.0),
                  child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      selectedEvents[index].boxTasks,
                      style: TextStyle(
                          decoration: selectedEvents[index].isChecked
                              ? TextDecoration.lineThrough
                              : null,
                          fontFamily: 'Pacifico'),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      checkColor: Colors.orange,
                      activeColor: Color(0xFFfee2b3),
                      value: selectedEvents[index].isChecked,
                      onChanged: (newValue) {
                        var getDate =
                            formatter.format(calendarController.selectedDay);
                        DateTime checkDate = DateTime.parse(getDate);
                        checkTask(selectedEvents[index].boxTasks, newValue,
                            checkDate, tasks);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        var getDate =
                            formatter.format(calendarController.selectedDay);
                        DateTime deleteDate = DateTime.parse(getDate);
                        deleteTask(
                            deleteDate, selectedEvents[index].boxTasks, tasks);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taskBloc.close();
  }
}
