import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/controller/Provider/favorite_provider.dart';
import 'package:sql_provider_/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, _) {
        return Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => provider.toggleFavorite(product),
                      child: Icon(
                        provider.isExist(product)
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                width: 130,
                child: Image.asset(
                  product.image,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                product.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                product.category,
                style: const TextStyle(fontSize: 14, color: Colors.red),
              ),
              Text(
                '\u20B9${product.price}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          // Handle tap event
                        },
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
