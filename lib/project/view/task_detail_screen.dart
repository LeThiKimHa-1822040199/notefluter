import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/task.dart';
import '../model/task_provider.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${task.description}'),
            Text('Status: ${task.status}'),
            Text('Priority: ${task.priority}'),
            Text('Due Date: ${task.dueDate?.toString() ?? 'None'}'),
            Text('Category: ${task.category ?? 'None'}'),
            if (task.attachments != null) ...[
              Text('Attachments:'),
              ...task.attachments!.map((url) => Text(url)),
            ],
            SizedBox(height: 20),
            DropdownButton<String>(
              value: task.status,
              items: ['To do', 'In progress', 'Done', 'Cancelled']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => Provider.of<TaskProvider>(context, listen: false)
                  .updateTask(task.copyWith(status: value!, completed: value == 'Done')),
            ),
          ],
        ),
      ),
    );
  }
}