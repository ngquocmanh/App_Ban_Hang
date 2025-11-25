import 'package:flutter/material.dart';
import 'package:app_01/db/historydb.dart';
import 'package:app_01/db/history.dart';

class HistoryProvider with ChangeNotifier {
  List<HistoryItem> _historyList = [];

  List<HistoryItem> get historyList => _historyList;
  Future<void> loadHistory() async {
    final db = await DBHelper.instance.db;
    final data = await db.query("history", orderBy: "id DESC");
    _historyList = data.map((e) => HistoryItem.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addToHistory(List cartItems) async {
    final db = await DBHelper.instance.db;

    for (var item in cartItems) {
      final history = HistoryItem(
        name: item.name1,
        quantity: item.quantity,
        price: item.price * item.quantity,
        image: item.image1,
      );

      await db.insert("history", history.toMap());
    }

    await loadHistory();
  }
  Future<void> deleteHistory(int id) async {
    final db = await DBHelper.instance.db;
    await db.delete("history", where: "id = ?", whereArgs: [id]);
    await loadHistory();
  }
  Future<void> clearHistory() async {
    final db = await DBHelper.instance.db;
    await db.delete("history");
    await loadHistory();
  }
}
