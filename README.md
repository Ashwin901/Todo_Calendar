# irisblocpattern

ToDo List App.

## Getting Started

The project starts with a calendar view from table_calendar: ^2.2.3 package .
It also has a view tasks button to view the tasks that the user has already added( you can also press the floating action button to view the tasks as well).The screen also has a floating action button using which we can add tasks to our calendar.The date with orange color signifies the present day whereas when u select a particular date it will have blue color.

![WhatsApp Image 2020-05-19 at 10 18 56 PM](https://user-images.githubusercontent.com/56069189/82354965-2db93e80-9a1f-11ea-998f-3464c0735afa.jpeg)
 
 If the user pushes the view tasks button then the dates which contain tasks will have a black dot signifying that it has tasks.
 
![get_initial_task_gif](https://user-images.githubusercontent.com/56069189/82358842-b5ee1280-9a24-11ea-9471-297df3b393d8.gif)

 To add tasks press the floating action button which will take the use to a alert dialog where you can add tasks.
 
 ![add_task_gif](https://user-images.githubusercontent.com/56069189/82359323-60fecc00-9a25-11ea-8eab-e675c60a1a96.gif)


TO view tasks of a particular date tap on the date and the tasks of that particular date will appear on the screen.

![view_tasks_gif](https://user-images.githubusercontent.com/56069189/82360141-8dffae80-9a26-11ea-8000-d311e91c4d79.gif)

To check or to notify that task has been completed the user can press the checkbox.

![getTask_gif](https://user-images.githubusercontent.com/56069189/82361035-e5524e80-9a27-11ea-9e6d-2986bbc160ea.gif)
 
To delete tasks the user has to tap on the delete icon.

![delete_task_gif](https://user-images.githubusercontent.com/56069189/82361512-8f31db00-9a28-11ea-98ed-ac095cc176d6.gif)

This  app has a Bloc pattern.The Bloc logic implementation is in the bloc.dart file.

The events to pass to the bloc.dart file is in the event.dart file.The state to accept from the bloc file is in the state.dart file. 

To pass event we have used .add() method.At the end the bloc is closed using .close() method.

The database used to store data is Hive.There are two adapters for hive in map_tasks.g.dart and task_elements.g.dart.
The model for these adapters are in map_tasks.dart and task_elements.dart
The name of the box is 'eventList'.
