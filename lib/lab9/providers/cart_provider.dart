import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cart => List.unmodifiable(_cart);

  int get count => _cart.length;

  int get totalPrice {
    int total = 0;

    for (var product in _cart) {
      total += product.price;
    }

    return total;
  }

  bool isInCart(Product product) {
    return _cart.any((item) => item.id == product.id);
  }

  void addProduct(Product product) {
    if (!isInCart(product)) {
      _cart.add(product);
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    _cart.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  void toggleProduct(Product product) {
    if (isInCart(product)) {
      removeProduct(product);
    } else {
      addProduct(product);
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
