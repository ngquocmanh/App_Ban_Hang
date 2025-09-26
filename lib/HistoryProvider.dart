import 'package:flutter/material.dart';
import 'Sanpham.dart';

class HistoryProvider with ChangeNotifier {
  final List<Product2> _history = [];

  List<Product2> get history => _history;

  void addToHistory(List<Product2> products) {
    _history.addAll(products.map((p) => Product2(
      name1: p.name1,
      price: p.price,
      image1: p.image1,
      quantity: p.quantity,
    )));
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}

