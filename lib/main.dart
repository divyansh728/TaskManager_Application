import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskmanager_application/pages/home_page.dart';
import 'package:taskmanager_application/theme/theme.dart';

import 'bloc/task_bloc.dart';
import 'bloc/task_event.dart';
import 'models/task_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc()..add(LoadTasksEvent())),
        BlocProvider(create: (_) => ThemeCubit()), // <- You need this
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Task Manager',
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(primary: Colors.deepPurple),
              appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(primary: Colors.deepPurple),
              appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple[700]),
            ),
            themeMode: themeMode,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
