import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../models/task_model.dart';


class TaskFormPage extends StatefulWidget {
  final Task? task;
  TaskFormPage({this.task});

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  DateTime _dueDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _dueDate = widget.task!.dueDate;
    } else {
      _title = '';
      _description = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => _title = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _description = value ?? '',
              ),
              SizedBox(height: 50),
              const Text(
                'Due Date',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 6),
              TextButton.icon(
                icon: Icon(Icons.calendar_today),
                label: Text(
                  _dueDate == null
                      ? 'Select Due Date'
                      : '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => _dueDate = picked);
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final task = Task(
                      title: _title,
                      description: _description,
                      dueDate: _dueDate,
                      isDone: widget.task?.isDone ?? false,
                    );
                    if (widget.task != null) {
                      final box = Hive.box<Task>('tasks');
                      box.put(widget.task!.key, task);
                      context.read<TaskBloc>().add(UpdateTaskEvent(task));
                    } else {
                      context.read<TaskBloc>().add(AddTaskEvent(task));
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  widget.task == null ? 'Add Task' : 'Update Task',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
