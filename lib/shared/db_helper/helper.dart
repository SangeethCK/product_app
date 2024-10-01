import 'dart:developer';

import 'package:mechinetest/features/cart/domain/model/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  static final CartDatabaseHelper _instance = CartDatabaseHelper._internal();
  factory CartDatabaseHelper() => _instance;

  static Database? _database;

  CartDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, productId INTEGER, productName TEXT, price REAL, quantity INTEGER)',
        );
      },
    );
  }

  Future<void> insertCartItem(CartItem item) async {
    final db = await database; // Access the database
    await db.insert(
      'cart',
      item.toMap(), // Use the CartItem toMap method
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return List.generate(maps.length, (i) {
      return CartItem.fromMap(maps[i]);
    });
  }

  Future<void> deleteCartItem(int productId) async {
    final db = await database;
    int result = await db.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );
    if (result > 0) {
      log('CartItem with productId $productId deleted successfully.');
    } else {
      log('Error: No CartItem found with productId $productId.');
    }
  }

  Future<void> updateCartItemQuantity(int productId, int newQuantity) async {
    final db = await database;
    await db.update(
      'cart',
      {'quantity': newQuantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }
}
