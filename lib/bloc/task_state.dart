
import '../models/task_model.dart';

abstract class TaskState {}
class TasksLoading extends TaskState {}
class TasksLoaded extends TaskState {
  final List<Task> tasks;
  TasksLoaded(this.tasks);
}