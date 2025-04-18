
import 'package:flutter/material.dart';
import '../model/note.dart';
import '../API/NoteApiHelper.dart';

class NoteForm extends StatefulWidget {
  final Note? note;
  final bool isEditMode;

  NoteForm({this.note, required this.isEditMode});

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _tagController;
  late int _priority;
  late List<String> _tags;
  String? _color;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _tagController = TextEditingController();
    _priority = widget.note?.priority ?? 1;
    _tags = widget.note?.tags ?? [];
    _color = widget.note?.color ?? '#FFFFFF';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Please enter content' : null,
              ),
              DropdownButtonFormField<int>(
                value: _priority,
                items: [
                  DropdownMenuItem(value: 1, child: Text('Low')),
                  DropdownMenuItem(value: 2, child: Text('Medium')),
                  DropdownMenuItem(value: 3, child: Text('High')),
                ],
                onChanged: (value) => setState(() => _priority = value!),
                decoration: InputDecoration(labelText: 'Priority'),
              ),
              TextFormField(
                controller: _tagController,
                decoration: InputDecoration(
                  labelText: 'Add Tag',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addTag,
                  ),
                ),
                onFieldSubmitted: (_) => _addTag(),
              ),
              Wrap(
                spacing: 8,
                children: _tags.map((tag) => Chip(
                  label: Text(tag),
                  onDeleted: () => setState(() => _tags.remove(tag)),
                )).toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveOrUpdateNote,
                child: Text(widget.isEditMode ? 'Update' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addTag() {
    if (_tagController.text.isNotEmpty) {
      setState(() {
        _tags.add(_tagController.text);
        _tagController.clear();
      });
    }
  }

  void _saveOrUpdateNote() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final note = Note(
        id: widget.note?.id,
        title: _titleController.text,
        content: _contentController.text,
        priority: _priority,
        createdAt: widget.note?.createdAt ?? now,
        modifiedAt: now,
        tags: _tags,
        color: _color,
      );

      final dbHelper = NoteApiHelper.instance;
      try {
        if (widget.isEditMode) {
          await dbHelper.updateNote(note);
        } else {
          await dbHelper.insertNote(note);
        }
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }
}
