import '../models/task_model.dart';

abstract class TaskEvent {}
class LoadTasksEvent extends TaskEvent {}
class AddTaskEvent extends TaskEvent {
  final Task task;
  AddTaskEvent(this.task);
}
class UpdateTaskEvent extends TaskEvent {
  final Task task;
  UpdateTaskEvent(this.task);
}
class DeleteTaskEvent extends TaskEvent {
  final Task task;
  DeleteTaskEvent(this.task);
}
class ToggleTaskStatusEvent extends TaskEvent {
  final Task task;
  ToggleTaskStatusEvent(this.task);
}