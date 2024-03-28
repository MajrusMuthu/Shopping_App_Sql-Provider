import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_provider_/controller/Provider/favorite_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Text(
                  "Favorites",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            child: Consumer<FavoriteProvider>(
              builder: (context, provider, _) {
                final finalList = provider.favorites;
                return finalList.isEmpty
                    ? const Center(
                        child: Text(
                          'No favorites added yet.',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: finalList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      final productToDelete = finalList[index];
                                      provider.toggleFavorite(productToDelete);
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: "Delete",
                                  )
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  finalList[index].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  finalList[index].description,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage(finalList[index].image),
                                  backgroundColor: Colors.blue.shade100,
                                ),
                                trailing: Text(
                                  '\u{20B9}${finalList[index].price}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
