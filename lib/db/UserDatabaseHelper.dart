import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'User.dart';

class UserDatabaseHelper {
  static final UserDatabaseHelper instance = UserDatabaseHelper._init();
  static Database? _database;

  UserDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
 //   await deleteDatabase(path);
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreateDB,
      onUpgrade: _onUpgrade,
    );
  }

  // Tạo bảng mới
  Future _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT UNIQUE,
        password TEXT NOT NULL,
        role TEXT DEFAULT 'user'
      )
    ''');


    await _insertDefaultAdmin(db);
  }

  // Upgrade database
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {

      await db.execute('ALTER TABLE users ADD COLUMN role TEXT DEFAULT "user"');
      await _insertDefaultAdmin(db);
    }
  }

  // Hàm thêm admin mặc định nếu chưa tồn tại
  Future<void> _insertDefaultAdmin(Database db) async {
    final existingAdmin = await db.query(
      'users',
      where: 'role = ?',
      whereArgs: ['admin'],
    );
    if (existingAdmin.isEmpty) {
      await db.insert('users', {
        'name': 'admin QuocManh',
        'email': 'quocmanh@gmail.com',
        'phone': '0333437424',
        'password': 'zxcvbnm',
        'role': 'admin',
      });
    }
  }

  // Đăng ký user
  Future<int> registerUser(User user) async {
    final db = await instance.database;
    Map<String, dynamic> data = user.toMap();
    data['role'] = 'user';
    return await db.insert(
      'users',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Login
  Future<User?> loginUser(String phone, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'phone = ? AND password = ?',
      whereArgs: [phone.trim(), password.trim()],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // Lấy user theo phone
  Future<User?> getUser(String phone) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'phone = ?',
      whereArgs: [phone],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }
}
