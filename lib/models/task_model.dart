import 'package:hive/hive.dart';
part 'task_model.g.dart';


// This tells Hive to generate this file

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  bool isDone;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isDone = false,
  });
}