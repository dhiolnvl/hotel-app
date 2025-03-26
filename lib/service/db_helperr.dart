import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tugas_4/customer/customer_016.dart';
import 'package:tugas_4/petugas/petugas_044.dart';
import 'dart:io';

class Database_Helper {
  Database_Helper._privateConstructor();
  static final Database_Helper instance = Database_Helper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'customer.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE customer (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT NOT NULL,
            alamat TEXT NOT NULL,
            email TEXT NOT NULL,
            no_hp TEXT NOT NULL
          )
    ''');

    await db.execute('''
    CREATE TABLE petugas(
      id INTEGER PRIMARY KEY,
      nama TEXT,
      bagian TEXT,
      email TEXT,
      no_hp TEXT
    )
    ''');
  }

  Future<List<Customer016>> getAllCustomer_016() async {
    Database db = await instance.database;
    var customer = await db.query('customer', orderBy: 'nama');
    List<Customer016> customerList = customer.isNotEmpty
        ? customer.map((e) => Customer016.fromMap(e)).toList()
        : [];
    return customerList;
  }

  Future<int> add(Customer016 customer) async {
    Database db = await instance.database;
    return await db.insert('customer', customer.toMap());
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('customer', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Customer016 customer) async {
    Database db = await instance.database;
    return await db.update('customer', customer.toMap(),
        where: "id = ?", whereArgs: [customer.id]);
  }



  // PETUGAS

    Future<List<Petugas044>> getAllPetugas044() async {
    Database db = await instance.database;
    var petugas = await db.query('petugas', orderBy: 'nama');
    List<Petugas044> mahasiswaList = petugas.isNotEmpty
        ? petugas.map((e) => Petugas044.fromMap(e)).toList()
        : [];
    return mahasiswaList;
  }

  Future<int> add_(Petugas044 petugas) async {
    Database db = await instance.database;
    return await db.insert('petugas', petugas.toMap());
  }

  Future<int> delete_(int id) async {
    Database db = await instance.database;
    return await db.delete('petugas', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update_(Petugas044 petugas) async {
    Database db = await instance.database;
    return await db.update('petugas', petugas.toMap(),
        where: "id = ?", whereArgs: [petugas.id]);
  }
}
