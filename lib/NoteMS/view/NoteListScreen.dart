
import 'package:flutter/material.dart';
import '../model/note.dart';
import '../API/NoteApiHelper.dart';
import '../view/NoteListItem.dart';
import '../view/NoteAdd.dart';
import '../view/NoteDetailScreen.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final NoteApiHelper dbHelper = NoteApiHelper.instance;
  List<Note> notes = [];
  bool isGridView = false;
  String searchQuery = '';
  int? filterPriority;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    List<Note> loadedNotes;
    if (searchQuery.isNotEmpty) {
      loadedNotes = await dbHelper.searchNotes(searchQuery);
    } else if (filterPriority != null) {
      loadedNotes = await dbHelper.getNotesByPriority(filterPriority!);
    } else {
      loadedNotes = await dbHelper.getAllNotes();
    }
    setState(() {
      notes = loadedNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => isGridView = !isGridView),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'refresh') {
                _loadNotes();
              } else if (value == 'filter') {
                _showFilterDialog();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'refresh', child: Text('Refresh')),
              PopupMenuItem(value: 'filter', child: Text('Filter by Priority')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Notes',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _loadNotes();
                });
              },
            ),
          ),
          Expanded(
            child: isGridView
                ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) => NoteListItem(
                note: notes[index],
                onTap: () => _navigateToDetail(context, notes[index]),
              ),
            )
                : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) => NoteListItem(
                note: notes[index],
                onTap: () => _navigateToDetail(context, notes[index]),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAdd(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAdd(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteAddScreen()),
    );
    if (result == true) _loadNotes();
  }

  void _navigateToDetail(BuildContext context, Note note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
    );
    if (result == true) _loadNotes();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter by Priority'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('All'),
              onTap: () {
                setState(() {
                  filterPriority = null;
                  _loadNotes();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Low'),
              onTap: () {
                setState(() {
                  filterPriority = 1;
                  _loadNotes();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Medium'),
              onTap: () {
                setState(() {
                  filterPriority = 2;
                  _loadNotes();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('High'),
              onTap: () {
                setState(() {
                  filterPriority = 3;
                  _loadNotes();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
