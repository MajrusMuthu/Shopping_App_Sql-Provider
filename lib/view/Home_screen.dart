// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/controller/Provider/selectCategory_provider.dart';
import 'package:sql_provider_/model/myProduct.dart';
import 'package:sql_provider_/view/details_page.dart';
import 'package:sql_provider_/view/widget/product_card.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProductCategory(index: 0, name: "All Products"),
                _buildProductCategory(index: 1, name: "Groceries"),
                _buildProductCategory(index: 2, name: "Furniture"),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildProductGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCategory({required int index, required String name}) {
    final provider = Provider.of<SelectedCategory>(context);

    return GestureDetector(
      onTap: () => provider.setSelectedCategoryIndex(index),
      child: Container(
        width: 105,
        height: 50,
        margin: const EdgeInsets.only(top: 10, right: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: provider.selectedIndex == index
              ? Colors.blueAccent
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    final selectedCategory =
        Provider.of<SelectedCategory>(context).selectedIndex;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 140),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: selectedCategory == 0
          ? MyProduct.allProducts.length
          : (selectedCategory - 1) == 0
              ? MyProduct.allGroceries.length
              : MyProduct.allFurnitures.length,
      itemBuilder: (context, index) {
        final product = selectedCategory == 0
            ? MyProduct.allProducts[index]
            : (selectedCategory - 1) == 0
                ? MyProduct.allGroceries[index]
                : MyProduct.allFurnitures[index];

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(product: product),
            ),
          ),
          child: ProductCard(product: product),
        );
      },
    );
  }
}
