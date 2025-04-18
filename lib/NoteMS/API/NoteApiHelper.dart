import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/note.dart';

class NoteApiHelper {
  static final NoteApiHelper instance = NoteApiHelper._init();
  static const String _baseUrl = 'https://my-json-server.typicode.com/LeThiKimHa/notefluter';

  NoteApiHelper._init();

  // Insert a new note
  Future<int> insertNote(Note note) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/notes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toMap()),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['id']; // Giả sử API trả về ID của note vừa tạo
    } else {
      throw Exception('Failed to insert note');
    }
  }

  // Get all notes
  Future<List<Note>> getAllNotes() async {
    final response = await http.get(Uri.parse('$_baseUrl/notes'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Note.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  // Get note by ID
  Future<Note?> getNoteById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/notes/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Note.fromMap(data);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load note');
    }
  }

  // Update a note
  Future<int> updateNote(Note note) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/notes/${note.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toMap()),
    );
    if (response.statusCode == 200) {
      return 1; // Trả về 1 để chỉ cập nhật thành công
    } else {
      throw Exception('Failed to update note');
    }
  }

  // Delete a note
  Future<int> deleteNote(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/notes/$id'));
    if (response.statusCode == 200) {
      return 1; // Trả về 1 để chỉ xóa thành công
    } else {
      throw Exception('Failed to delete note');
    }
  }

  // Get notes by priority
  Future<List<Note>> getNotesByPriority(int priority) async {
    final response = await http.get(Uri.parse('$_baseUrl/notes?priority=$priority'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Note.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load notes by priority');
    }
  }

  // Search notes
  Future<List<Note>> searchNotes(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/notes?q=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Note.fromMap(json)).toList();
    } else {
      throw Exception('Failed to search notes');
    }
  }

// Không cần close() vì không sử dụng kết nối database
}