import 'package:flutter_food_app/model/Order.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OrderDatabase {
  static final OrderDatabase instance = OrderDatabase._init();

  static Database? _database;
  OrderDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('orders.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableOrders(
    ${OrderFileds.id} $idType,
    ${OrderFileds.foodImage} $textType,
    ${OrderFileds.foodName} $textType,
    ${OrderFileds.foodPrice} $textType,
    ${OrderFileds.foodQuantity} $textType,
    ${OrderFileds.foodTotalPrice} $textType
    )
    ''');
  }

  Future<Order> create(Order order) async {
    final db = await instance.database;
    final id = await db.insert(tableOrders, order.toJson());
    return order.copy(id: id);
  }

  Future<Order> readOrder(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableOrders,
      columns: OrderFileds.values,
      where: '${OrderFileds.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Order.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Order>> readAllOreders() async {
    final db = await instance.database;
    final result = await db.query(tableOrders);

    return result.map((json) => Order.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
