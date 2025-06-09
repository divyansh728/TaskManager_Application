import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager_application/pages/task_edit_page.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../theme/theme.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Task Manager'),
    actions: [
    IconButton(
    icon: Icon(Icons.brightness_6),
    onPressed: () => context.read<ThemeCubit>().toggleTheme(),
    ),
    PopupMenuButton<String>(
    onSelected: (value) => setState(() => filter = value),
    itemBuilder: (context) => [
    PopupMenuItem(value: 'All', child: Text('All')),
    PopupMenuItem(value: 'Completed', child: Text('Completed')),
    PopupMenuItem(value: 'Pending', child: Text('Pending')),
    ],
    )
    ],
    ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            final tasks = state.tasks.where((task) {
              if (filter == 'Completed') return task.isDone;
              if (filter == 'Pending') return !task.isDone;
              return true;
            }).toList();
            return
              ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Dismissible(
                  key: Key(task.key.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (_) {
                    context.read<TaskBloc>().add(DeleteTaskEvent(task));
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(task.title)),
                        Chip(
                          label: Text(
                            task.isDone ? 'Completed' : 'Pending',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: task.isDone ? Colors.green : Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ],
                    ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.description,
                            style: TextStyle(
                              decoration: task.isDone ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Due: ${task.dueDate.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: task.isDone,
                        onChanged: (_) {
                          context.read<TaskBloc>().add(ToggleTaskStatusEvent(task));
                        },
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TaskFormPage(task: task)),
                        );
                      },
                    ),
                  ),
                );

              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskFormPage()),
          );
        },
        label: Text('Add Task', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        elevation: 6,
        hoverElevation: 10,
        splashColor: Colors.purpleAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
