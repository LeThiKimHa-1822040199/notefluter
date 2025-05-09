import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/task.dart';
import '../model/task_provider.dart';
import '../view/task_detail_screen.dart';
import '../view/task_form_screen.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      leading: CircleAvatar(
        backgroundColor: task.priority == 3 ? Colors.red : task.priority == 2 ? Colors.yellow : Colors.green,
        radius: 10,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(task.completed ? Icons.check_circle : Icons.circle_outlined),
            onPressed: () => Provider.of<TaskProvider>(context, listen: false).toggleTaskCompletion(task),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TaskFormScreen(task: task)),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id),
          ),
        ],
      ),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task))),
    );
  }
}