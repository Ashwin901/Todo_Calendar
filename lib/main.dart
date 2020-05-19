import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:irisblocpattern/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'map_tasks.dart';
import 'task_elements.dart';
import 'welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final dir=await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter( MapTasksAdapter());
  Hive.registerAdapter(TaskElementsAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:BlocProvider<TaskBloc>(create: (context)=>TaskBloc(),
          child: WelcomeScreen()),
    );
  }
}

