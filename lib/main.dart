import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/controller/Provider/cart_provider.dart';
import 'package:sql_provider_/controller/Provider/favorite_provider.dart';
import 'package:sql_provider_/controller/Provider/product_provider.dart';
import 'package:sql_provider_/controller/Provider/selectCategory_provider.dart';
import 'package:sql_provider_/controller/Provider/navigation_provider.dart';
import 'package:sql_provider_/controller/Provider/selectedSize_provider.dart';
import 'package:sql_provider_/view/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => FavoriteProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => SelectedCategory()),
            ChangeNotifierProvider(create: (_) => ProductsProvider()),
             ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
             ChangeNotifierProvider(create: (_) => SizeSelection()),
             
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            
            title: 'E-Shop App',
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: MainPage(),
          ));
}
