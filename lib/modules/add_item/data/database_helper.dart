// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE tasks(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT,
              date TEXT,
              time TEXT
            )''',
        );
      },
      version: 1,
    );
  }

  // إضافة مهمة جديدة
  Future<void> insertTask(Map<String, dynamic> task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return db.query('tasks');
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateTask(Map<String, dynamic> task, int id) async {
    final db = await database;
    await db.update(
      'tasks',
      task,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
