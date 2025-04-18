
import 'package:flutter/material.dart';
import '../model/note.dart';

class NoteListItem extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  NoteListItem({required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getPriorityColor(note.priority),
      child: ListTile(
        title: Text(note.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              'Modified: ${note.modifiedAt.toString().substring(0, 16)}',
              style: TextStyle(fontSize: 12),
            ),
            if (note.tags != null && note.tags!.isNotEmpty)
              Wrap(
                spacing: 4,
                children: note.tags!.map((tag) => Chip(label: Text(tag, style: TextStyle(fontSize: 10)))).toList(),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green[100]!;
      case 2:
        return Colors.yellow[100]!;
      case 3:
        return Colors.red[100]!;
      default:
        return Colors.white;
    }
  }
}
