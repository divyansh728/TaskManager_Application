import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final Box<Task> taskBox = Hive.box<Task>('tasks');

  TaskBloc() : super(TasksLoading()) {
    on<LoadTasksEvent>((event, emit) {
      emit(TasksLoaded(taskBox.values.toList()));
    });
    on<AddTaskEvent>((event, emit) async {
      await taskBox.add(event.task);
      emit(TasksLoaded(taskBox.values.toList()));
    });
    on<UpdateTaskEvent>((event, emit) async {
      await event.task.save();
      emit(TasksLoaded(taskBox.values.toList()));
    });
    on<DeleteTaskEvent>((event, emit) async {
      await event.task.delete();
      emit(TasksLoaded(taskBox.values.toList()));
    });
    on<ToggleTaskStatusEvent>((event, emit) async {
      event.task.isDone = !event.task.isDone;
      await event.task.save();
      emit(TasksLoaded(taskBox.values.toList()));
    });
  }
}
