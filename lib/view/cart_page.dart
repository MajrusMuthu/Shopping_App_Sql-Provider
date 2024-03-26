// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/controller/Provider/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, List<Map<String, dynamic>>? cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartProvider _cartProvider; // Store provider instance

  @override
  void initState() {
    super.initState();
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    _cartProvider.loadCartFromDatabase(); // Load data on initialization
  }

  @override
  Widget build(BuildContext context) {
    // final finalList = _cartProvider.cart;
    Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Cart",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: const BackButton(
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Consumer<CartProvider>(builder: (context, cartProvider, _) {
          final cartItems = cartProvider.cart;
          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                'No items in the cart',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              return Slidable(
                key: Key(product.id.toString()),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) =>
                          cartProvider.removeProduct(product),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: "Delete",
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(product.image),
                  ),
                  title: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: SizedBox(
                    width: 120,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () =>
                              _cartProvider.decrementQuantity(index),
                        ),
                        Text(
                          product.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () =>
                              _cartProvider.incrementQuantity(index),
                        ),
                      ],
                    ),
                  ),
                  tileColor: Colors.white,
                ),
              );
            },
          );
        }),
        bottomSheet:
            Consumer<CartProvider>(builder: (context, cartProvider, _) {
          final totalPrice = cartProvider.calculateTotalPrice();
          final totalQuantity = cartProvider.calculateTotalQuantity();
          return BottomAppBar(
            color: Colors.blue,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price: \u20B9$totalPrice',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total Items: $totalQuantity',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_cart,
                            color: Colors.white),
                        label: const Text(
                          "Purchase",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
