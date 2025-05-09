import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../model/task.dart';
import '../model/task_provider.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;

  const TaskFormScreen({this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;
  String _status = 'To do';
  int _priority = 1;
  String? _category, _assignedTo;
  List<String> _attachments = [];

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _dueDate = widget.task!.dueDate;
      _status = widget.task!.status;
      _priority = widget.task!.priority;
      _category = widget.task!.category;
      _assignedTo = widget.task!.assignedTo;
      _attachments = widget.task!.attachments ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final user = provider.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField(
                  value: _status,
                  items: ['To do', 'In progress', 'Done', 'Cancelled']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => _status = value!),
                  decoration: InputDecoration(labelText: 'Status'),
                ),
                DropdownButtonFormField(
                  value: _priority,
                  items: [1, 2, 3].map((e) => DropdownMenuItem(value: e, child: Text(e.toString()))).toList(),
                  onChanged: (value) => setState(() => _priority = value!),
                  decoration: InputDecoration(labelText: 'Priority'),
                ),
                TextFormField(
                  initialValue: _category,
                  decoration: InputDecoration(labelText: 'Category'),
                  onChanged: (value) => _category = value.isEmpty ? null : value,
                ),
                TextButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) setState(() => _dueDate = date);
                  },
                  child: Text(_dueDate == null ? 'Select Due Date' : _dueDate!.toString()),
                ),
                if (user!.isAdmin)
                  DropdownButtonFormField(
                    value: _assignedTo,
                    items: provider.users
                        .map((u) => DropdownMenuItem(value: u.id, child: Text(u.username)))
                        .toList(),
                    onChanged: (value) => setState(() => _assignedTo = value),
                    decoration: InputDecoration(labelText: 'Assign To'),
                  ),
                ElevatedButton(
                  onPressed: () => setState(() => _attachments.add('https://example.com/file${_attachments.length + 1}')),
                  child: Text('Add Attachment'),
                ),
                if (_attachments.isNotEmpty) ..._attachments.map((url) => Text(url)).toList(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final task = Task(
                          id: widget.task?.id ?? Uuid().v4(),
                          title: _titleController.text,
                          description: _descriptionController.text,
                          status: _status,
                          priority: _priority,
                          dueDate: _dueDate,
                          createdAt: widget.task?.createdAt ?? DateTime.now(),
                          updatedAt: DateTime.now(),
                          assignedTo: user!.isAdmin ? _assignedTo : user.id,
                          createdBy: user.id,
                          category: _category,
                          attachments: _attachments,
                          completed: _status == 'Done',
                        );
                        if (widget.task == null) {
                          await provider.addTask(task);
                        } else {
                          await provider.updateTask(task);
                        }
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                      }
                    }
                  },
                  child: Text(widget.task == null ? 'Add' : 'Update'),
                ),
                if (widget.task != null)
                  ElevatedButton(
                    onPressed: () async {
                      await provider.deleteTask(widget.task!.id);
                      Navigator.pop(context);
                    },
                    child: Text('Delete'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}