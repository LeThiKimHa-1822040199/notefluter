import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/user.dart';
import '../model/task.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        avatar TEXT,
        createdAt DATETIME NOT NULL,
        lastActive DATETIME NOT NULL,
        isAdmin BOOLEAN NOT NULL DEFAULT 0
      )
    ''');
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        status TEXT NOT NULL,
        priority INTEGER NOT NULL,
        dueDate DATETIME,
        createdAt DATETIME NOT NULL,
        updatedAt DATETIME NOT NULL,
        assignedTo TEXT,
        createdBy TEXT NOT NULL,
        category TEXT,
        completed BOOLEAN NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE attachments (
        id TEXT PRIMARY KEY,
        taskId TEXT NOT NULL,
        url TEXT NOT NULL
      )
    ''');
    await db.execute('CREATE INDEX idx_tasks_status ON tasks(status)');

    // Tạo tài khoản admin mặc định
    await db.insert('users', User(
      id: Uuid().v4(),
      username: 'admin',
      password: 'admin123',
      email: 'admin@example.com',
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
      isAdmin: true,
    ).toMap());
  }

  Future<void> createUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await database;
    final maps = await db.query('users', where: 'username = ?', whereArgs: [username]);
    return maps.isNotEmpty ? User.fromMap(maps.first) : null;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final maps = await db.query('users');
    return maps.map((map) => User.fromMap(map)).toList();
  }

  Future<void> createTask(Task task) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.insert('tasks', task.toMap());
      if (task.attachments != null) {
        for (var url in task.attachments!) {
          await txn.insert('attachments', {'id': Uuid().v4(), 'taskId': task.id, 'url': url});
        }
      }
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
      await txn.delete('attachments', where: 'taskId = ?', whereArgs: [task.id]);
      if (task.attachments != null) {
        for (var url in task.attachments!) {
          await txn.insert('attachments', {'id': Uuid().v4(), 'taskId': task.id, 'url': url});
        }
      }
    });
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('attachments', where: 'taskId = ?', whereArgs: [id]);
      await txn.delete('tasks', where: 'id = ?', whereArgs: [id]);
    });
  }

  Future<List<Task>> searchTasks({String? query, String? status, String? userId, bool isAdmin = false}) async {
    final db = await database;
    String where = '1=1';
    List<dynamic> whereArgs = [];
    if (query != null) {
      where += ' AND (title LIKE ? OR description LIKE ?)';
      whereArgs.addAll(['%$query%', '%$query%']);
    }
    if (status != null) {
      where += ' AND status = ?';
      whereArgs.add(status);
    }
    if (!isAdmin && userId != null) {
      where += ' AND (assignedTo = ? OR createdBy = ?)';
      whereArgs.addAll([userId, userId]);
    }
    final maps = await db.query('tasks', where: where, whereArgs: whereArgs);
    List<Task> tasks = [];
    for (var map in maps) {
      final attachments = await db.query('attachments', where: 'taskId = ?', whereArgs: [map['id']]);
      tasks.add(Task.fromMap(map, attachments.map((e) => e['url'] as String).toList()));
    }
    return tasks;
  }
}