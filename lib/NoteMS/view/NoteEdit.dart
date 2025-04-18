
import 'package:flutter/material.dart';
import '../model/note.dart';
import '../view/NoteForm.dart';

class NoteEditScreen extends StatelessWidget {
  final Note note;

  NoteEditScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Note')),
      body: NoteForm(note: note, isEditMode: true),
    );
  }
}
