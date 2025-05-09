import 'package:flutter/material.dart';
import '../db/databasehelper.dart';
import 'user.dart';
import 'task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<User> _users = [];
  User? _currentUser;

  List<Task> get tasks => _tasks;
  List<User> get users => _users;
  User? get currentUser => _currentUser;

  Future<void> setCurrentUser(String username, String password) async {
    try {
      final user = await DatabaseHelper.instance.getUserByUsername(username);
      if (user != null && user.password == password) {
        _currentUser = user;
        await _fetchData();
        notifyListeners();
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> _fetchData() async {
    try {
      await Future.wait([
        fetchTasks(),
        fetchUsers(),
      ]);
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> fetchTasks() async {
    try {
      _tasks = await DatabaseHelper.instance.searchTasks(
        userId: _currentUser?.id,
        isAdmin: _currentUser?.isAdmin ?? false,
      );
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  Future<void> fetchUsers() async {
    try {
      _users = await DatabaseHelper.instance.getAllUsers();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      if (_currentUser == null) throw Exception('User not logged in');
      if (!_currentUser!.isAdmin && task.assignedTo != _currentUser!.id) {
        throw Exception('Only admins can assign tasks to others');
      }
      await DatabaseHelper.instance.createTask(task);
      await fetchTasks();
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      if (_currentUser == null) throw Exception('User not logged in');
      if (!_currentUser!.isAdmin && task.assignedTo != _currentUser!.id) {
        throw Exception('Only admins can assign tasks to others');
      }
      await DatabaseHelper.instance.updateTask(task);
      await fetchTasks();
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await DatabaseHelper.instance.deleteTask(id);
      await fetchTasks();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    try {
      await updateTask(task.copyWith(
        status: task.completed ? 'To do' : 'Done',
        completed: !task.completed,
      ));
    } catch (e) {
      throw Exception('Failed to toggle task completion: $e');
    }
  }

  Future<void> searchTasks(String query) async {
    try {
      _tasks = await DatabaseHelper.instance.searchTasks(
        query: query,
        userId: _currentUser?.id,
        isAdmin: _currentUser?.isAdmin ?? false,
      );
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to search tasks: $e');
    }
  }

  Future<void> filterByStatus(String status) async {
    try {
      _tasks = await DatabaseHelper.instance.searchTasks(
        status: status,
        userId: _currentUser?.id,
        isAdmin: _currentUser?.isAdmin ?? false,
      );
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to filter tasks: $e');
    }
  }
}