import 'package:flutter/material.dart';
import '../product/Sanpham.dart';

class CartProvider with ChangeNotifier {
  final List<Product2> _cart = [];

  List<Product2> get cart => _cart;

  void addToCart(Product2 product) {
    final index = _cart.indexWhere((item) => item.name1 == product.name1);
    if (index != -1) {
      _cart[index].quantity += 1;
    } else {
      product.quantity = 1;
      _cart.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(Product2 product) {
    final index = _cart.indexWhere((item) => item.name1 == product.name1);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity -= 1;
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in _cart) {
      total += item.price * item.quantity;
    }
    return total;
  }
  int get cartCount => _cart.length;
}
