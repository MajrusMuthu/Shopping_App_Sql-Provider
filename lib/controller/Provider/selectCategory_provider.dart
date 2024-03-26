import 'package:flutter/material.dart';

class SelectedCategory extends ChangeNotifier {
  int _selectedIndex = 0; // Initial selected index (All Products)

  int get selectedIndex => _selectedIndex;

  void setSelectedCategoryIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); 
  }
}
