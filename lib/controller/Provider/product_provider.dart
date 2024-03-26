

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/controller/Provider/selectCategory_provider.dart';
import 'package:sql_provider_/model/myProduct.dart';
import 'package:sql_provider_/model/product.dart';

class ProductsProvider extends ChangeNotifier {
  final List<Product> allProducts = MyProduct.allProducts; // Assuming MyProduct holds product data

  List<Product> get filteredProducts {
    if (Provider.of<SelectedCategory>(context as BuildContext, listen: false).selectedIndex == 0) {
      return allProducts; // Show all products if index is 0
    } else {
      final selectedCategory = Provider.of<SelectedCategory>(context as BuildContext, listen: false).selectedIndex - 1; // Adjust for initial "All Products"
      return allProducts.where((product) => product.category == categories[selectedCategory]).toList(); // Filter based on category
    }
  }

  final List<String> categories = ["All Products", "Groceries", "Furniture"]; // Assuming category list
}
