import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'User.dart';
class UserDatabaseHelper {
  static final UserDatabaseHelper instance = UserDatabaseHelper._init();
  static Database? _database;
   UserDatabaseHelper._init();

   Future<Database> get database async{
     if(_database != null) return _database!;
     _database = await _initDB('user.db');
     return _database!;
   }


  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB,
    );
  }

  Future _onCreateDB(Database db, int version) async{
     await db.execute(
       ''' CREATE TABLE users(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       name TEXT NOT NULL,
       email TEXT NOT NULL,
       phone TEXT UNIQUE,
       password TEXT NOT NULL
       )
        '''
     );
  }
  //Tao tai khoan
  Future<int> regesterUser(User user) async{
     final db = await instance.database;
     return await db.insert('users', user.toMap() ,conflictAlgorithm:  ConflictAlgorithm.replace);
  }
  //Đnhap bang sdt va pass
  Future<User?> loginUser(String phone, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'phone = ? AND password = ?',
      whereArgs: [phone, password],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }
  //Lấy thông tin cá nhân từ đky
  Future<User?> getUser(String phone) async{
     final db = await instance.database;
     final result = await db.query('users' , where: 'phone = ?' ,whereArgs: [phone],
     );
     if(result.isNotEmpty){
       return User.fromMap(result.first);
     }return null;
  }

}


