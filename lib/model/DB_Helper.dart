import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_provider_/model/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static late Database _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await initDatabase(); 
    return _database;
  }

Future<Database> initDatabase() async {
  try {
    final path = join(await getDatabasesPath(), 'product_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            name TEXT,
            category TEXT,
            image TEXT,
            description TEXT,
            price REAL,
            quantity INTEGER
          )
        ''');
      },
    );
    return _database; 
  } catch (e) {
    print("Error initializing database: $e");
    throw Exception("Failed to initialize database");
  }
}


Future<void> insertProduct(Product product) async {
  final db = await database;
  await db.insert(
    'products',
    product.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        name: maps[i]['name'],
        category: maps[i]['category'],
        image: maps[i]['image'],
        description: maps[i]['description'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  Future<void> deleteProduct(int id) async {
    final db = await database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllProducts() async {
    final db = await database;
    await db.delete('products');
  }

  // Add methods for updating products as needed...
}
