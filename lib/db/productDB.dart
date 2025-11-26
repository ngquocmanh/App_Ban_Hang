import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_01/product/Sanpham.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();
  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1,
        onCreate: (db, version) async {
          await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        mota TEXT,
        quantity INTEGER DEFAULT 1,
        image TEXT
      )
      ''');
        });
  }
  Future<int> insertProduct(Product2 product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }
  Future<List<Product2>> getProducts() async {
    final db = await instance.database;
    final result = await db.query('products');
    return result.map((json) => Product2.fromMap(json)).toList();
  }
  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
