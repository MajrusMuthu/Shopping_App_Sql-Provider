import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/model/DB_Helper.dart';
import 'package:sql_provider_/model/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  //addToCart
  Future<void> addToCart(Product product) async {
    _cart.add(product);
    await _databaseHelper.insertProduct(product);
    notifyListeners();
  }

  // Remove product from cart and database
  void removeProduct(Product product) {
    _cart.removeWhere((element) => element.id == product.id);
    _databaseHelper.deleteProduct(product.id); // Delete from database
    notifyListeners(); // Notify listeners about the change
  }

  // Load cart from database
  Future<void> loadCartFromDatabase() async {
    List<Product> products = await _databaseHelper.getProducts();
    _cart.clear();
    _cart.addAll(products);
    notifyListeners();
  }

  // Increment quantity of a product in the cart
  void incrementQuantity(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  // Decrement quantity of a product in the cart
  void decrementQuantity(int index) {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
      notifyListeners();
    }
  }

  // Calculate total price of items in the cart
  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var product in _cart) {
      totalPrice += (product.price * product.quantity);
    }
    return totalPrice;
  }

  // Calculate total quantity of items in the cart
  int calculateTotalQuantity() {
    int totalQuantity = 0;
    for (var product in _cart) {
      totalQuantity += product.quantity;
    }
    return totalQuantity;
  }

  static CartProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<CartProvider>(context, listen: listen);
  }
}
