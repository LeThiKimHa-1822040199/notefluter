import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/task_provider.dart';
import 'task_form_screen.dart';
import '../view/task_item.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: TaskSearchDelegate()),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(value: 'To do', child: Text('To do')),
              PopupMenuItem(value: 'In progress', child: Text('In progress')),
              PopupMenuItem(value: 'Done', child: Text('Done')),
              PopupMenuItem(value: 'Cancelled', child: Text('Cancelled')),
            ],
            onSelected: (value) => Provider.of<TaskProvider>(context, listen: false).filterByStatus(value as String),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, _) => ListView.builder(
          itemCount: provider.tasks.length,
          itemBuilder: (context, index) => TaskItem(task: provider.tasks[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskFormScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskSearchDelegate extends SearchDelegate {
  @override
  Widget buildResults(BuildContext context) =>
      Consumer<TaskProvider>(builder: (context, provider, _) {
        provider.searchTasks(query);
        return ListView.builder(
          itemCount: provider.tasks.length,
          itemBuilder: (context, index) => TaskItem(task: provider.tasks[index]),
        );
      });

  @override
  Widget buildSuggestions(BuildContext context) => Container();

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(icon: Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
}