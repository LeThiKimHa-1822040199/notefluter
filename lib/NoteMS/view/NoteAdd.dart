
import 'package:flutter/material.dart';
import '../view/NoteForm.dart';

class NoteAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Note')),
      body: NoteForm(isEditMode: false),
    );
  }
}
