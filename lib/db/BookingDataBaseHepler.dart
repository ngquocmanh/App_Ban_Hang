import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class BookingDataBaseHelper {
  static final BookingDataBaseHelper instance = BookingDataBaseHelper._init();
  static Database? _database;
  BookingDataBaseHelper._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_01.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE booking(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        soBan TEXT NOT NULL,
        bookingdate TEXT NOT NULL,
        bookingtime TEXT NOT NULL
      )
    ''');
  }
  Future<int> insertBooking(Map<String, dynamic> booking) async {
    final db = await instance.database;
    return await db.insert('booking', booking);
  }

  // Đọc tất cả các booking
  Future<List<Map<String, dynamic>>> getAllBookings() async {
    final db = await instance.database;
    return await db.query('booking');
  }

  Future<int> deleteBooking(int id) async {
    final db = await instance.database;
    return await db.delete(
      'booking',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
