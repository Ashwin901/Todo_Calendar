# irisblocpattern

ToDo List App.

## Getting Started

The project starts with a calendar view from table_calendar: ^2.2.3 package .
It also has a view tasks button to view the tasks that the user has already added( you can also press the floating action button to view the tasks as well).The screen also has a floating action button using which we can add tasks to our calendar.The date with orange color signifies the present day whereas when u select a particular date it will have blue color.


 
 If the user pushes the view tasks button then the dates which contain tasks will have a black dot signifying that it has tasks.
 


 To add tasks press the floating action button which will take the use to a alert dialog where you can add tasks.
 



TO view tasks of a particular date tap on the date and the tasks of that particular date will appear on the screen.


To check or to notify that task has been completed the user can press the checkbox.

 
To delete tasks the user has to tap on the delete icon.


The WelcomeScreen class which is the screen seen by the user is in welcome_screen.dart file

This  app has a Bloc pattern.The Bloc logic implementation is in the bloc.dart file.

The events to pass to the bloc.dart file is in the event.dart file.The state to accept from the bloc file is in the state.dart file. 

To pass event we have used .add() method.At the end the bloc is closed using .close() method.

The database used to store data is Hive.There are two adapters for hive in map_tasks.g.dart and task_elements.g.dart.
The model for these adapters are in map_tasks.dart and task_elements.dart
The name of the box is 'eventList'.
Instance of MapTasks are added to the box.The MapTasks has two variables eventsDate and events.Where events is a list of 'TaskElements'.
The TaskElements class has two variables boxTasks(which is the task entered by the user) and isChecked(to check if the user has checked or finished the task).


