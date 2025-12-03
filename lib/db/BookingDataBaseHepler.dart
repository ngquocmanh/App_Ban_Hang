import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'book_table.dart';

class BookingDataBaseHelper {
  static final BookingDataBaseHelper instance = BookingDataBaseHelper._init();
  static Database? _database;

  BookingDataBaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('booking.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreateDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        soBan TEXT NOT NULL,
        bookingdate TEXT NOT NULL,
        bookingtime TEXT NOT NULL,
        FOREIGN KEY(userId) REFERENCES users(userID) ON DELETE CASCADE
      )
    ''');
  }


  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE bookings RENAME TO old_bookings');
      await db.execute('''
        CREATE TABLE bookings(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId INTEGER NOT NULL,
          name TEXT NOT NULL,
          phone TEXT NOT NULL,
          soBan TEXT NOT NULL,
          bookingdate TEXT NOT NULL,
          bookingtime TEXT NOT NULL,
          FOREIGN KEY(userId) REFERENCES users(userID) ON DELETE CASCADE
        )
      ''');

      await db.execute('''
        INSERT INTO bookings(id, userId, name, phone, soBan, bookingdate, bookingtime)
        SELECT id, 0 AS userId, name, phone, soBan, bookingdate, bookingtime
        FROM old_bookings
      ''');
      await db.execute('DROP TABLE old_bookings');
    }
  }
  Future<int> insertBooking(Map<String, dynamic> booking) async {
    final db = await instance.database;
    return await db.insert('bookings', booking);
  }
  Future<List<Booking>> getBookingsByUser(int userId) async {
    final db = await instance.database;
    final maps = await db.query(
      'bookings',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return maps.map((map) => Booking.fromMap(map)).toList();
  }

  Future<int> deleteBooking(int id) async {
    final db = await instance.database;
    return await db.delete('bookings', where: 'id = ?', whereArgs: [id]);
  }
}
