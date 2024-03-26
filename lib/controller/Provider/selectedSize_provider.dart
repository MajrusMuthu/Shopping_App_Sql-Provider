import 'package:flutter/material.dart';

class SizeSelection extends ChangeNotifier {
  String _selectedSize = "";

  String get selectedSize => _selectedSize;

  void setSelectedSize(String size) {
    _selectedSize = size;
    notifyListeners();
  }
}
