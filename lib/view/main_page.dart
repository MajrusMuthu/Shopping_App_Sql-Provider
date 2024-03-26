import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/controller/Provider/cart_provider.dart';
import 'package:sql_provider_/controller/Provider/navigation_provider.dart';
import 'package:sql_provider_/view/Favorite_screen.dart';
import 'package:sql_provider_/view/Home_screen.dart';
import 'package:sql_provider_/view/Profile_screen.dart';
import 'package:sql_provider_/view/cart_page.dart';
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationBarProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "E-Shopping App",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            Consumer<CartProvider>(
              builder: (context, cartProvider, _) {
                int itemCount = cartProvider.cart.length;
                return Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartPage()),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                    if (itemCount > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$itemCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: Consumer<BottomNavigationBarProvider>(
          builder: (context, provider, _) {
            return IndexedStack(
              index: provider.currentIndex,
              children: const [
                Home_Screen(),
                Favorite_Screen(),
                Profile_Screen(),
              ],
            );
          },
        ),
        bottomNavigationBar: Consumer<BottomNavigationBarProvider>(
          builder: (context, provider, _) {
            return BottomNavigationBar(
              currentIndex: provider.currentIndex,
              onTap: (index) {
                provider.setIndex(index);
              },
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
              ],
            );
          },
        ),
      ),
    );
  }
}


