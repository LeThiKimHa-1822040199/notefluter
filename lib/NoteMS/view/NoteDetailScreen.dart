import 'package:app_mobie2/NoteMS/API/NoteApiHelper.dart';
import 'package:flutter/material.dart';
import '../model/note.dart';
import '../API/NoteApiHelper.dart'; // Thay đổi từ NoteDatabaseHelper sang NoteApiHelper
import '../view/NoteEdit.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  NoteDetailScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _navigateToEdit(context),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteNote(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Content:', style: Theme.of(context).textTheme.bodySmall),
            Text(note.content),
            SizedBox(height: 16),
            Text('Priority: ${note.priority == 1 ? 'Low' : note.priority == 2 ? 'Medium' : 'High'}'),
            Text('Created: ${note.createdAt.toString().substring(0, 16)}'),
            if (note.tags != null && note.tags!.isNotEmpty) ...[
              SizedBox(height: 16),
              Text('Tags:', style: Theme.of(context).textTheme.bodyLarge),
              Wrap(
                spacing: 8,
                children: note.tags!.map((tag) => Chip(label: Text(tag))).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _navigateToEdit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditScreen(note: note)),
    );
    if (result == true) Navigator.pop(context, true);
  }

  void _deleteNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note'),
        content: Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                final apiHelper = NoteApiHelper.instance; // Sử dụng NoteApiHelper
                await apiHelper.deleteNote(note.id!); // Gọi API để xóa
                Navigator.pop(context); // Đóng dialog
                Navigator.pop(context, true); // Quay lại màn hình trước và báo hiệu thành công
              } catch (e) {
                Navigator.pop(context); // Đóng dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete note: $e')),
                );
              }
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}