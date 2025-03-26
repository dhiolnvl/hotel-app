import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE kamar(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        no_kamar TEXT,
        jenis_kamar TEXT,
        tarif INTEGER,
        fasilitas TEXT,
        status TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('hotel.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createData(String no_kamar, String jenis_kamar, int tarif,
      String fasilitas, String status) async {
    final db = await SQLHelper.db(); // Membuka koneksi database
    final data = {
      'no_kamar': no_kamar,
      'jenis_kamar': jenis_kamar,
      'tarif': tarif,
      'fasilitas': fasilitas,
      'status': status,
      'created_at': DateTime.now().toString(),
    };
    final id = await db.insert('kamar', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    return db.query('kamar', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    return db.query('kamar', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(int id, String no_kamar, String jenis_kamar,
      int tarif, String fasilitas, String status) async {
    final db = await SQLHelper.db();
    final data = {
      'no_kamar': no_kamar,
      'jenis_kamar': jenis_kamar,
      'tarif': tarif,
      'fasilitas': fasilitas,
      'status': status,
      'created_at': DateTime.now().toString(),
    };
    final result =
        await db.update('kamar', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('kamar', where: 'id = ?', whereArgs: [id]);
    } catch (e) {}
  }

  static Future<Map<String, dynamic>> getDataById(int id) async {
    final db = await SQLHelper.db();
    var result = await db.query(
      'kamar',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : {};
  }


  static Future<bool> cekNoKamarAda(String no_kamar) async {
    final db = await SQLHelper.db();


    final result = await db.query(
      'kamar',
      where: 'no_kamar = ?',
      whereArgs: [no_kamar],
    );

    return result.isNotEmpty;
  }


  static Future<int> getKamarCount() async {
    final db = await SQLHelper.db();

    final result = await db.rawQuery('SELECT COUNT(*) FROM kamar');
    if (result.isNotEmpty) {
      return result[0]['COUNT(*)'] as int;
    } else {
      return 0;
    }
  }


  static Future<int> getJumlahKamartersedia() async {
    final db = await SQLHelper.db();

    final result = await db
        .rawQuery('SELECT COUNT(*) FROM kamar WHERE status = ?', ['Tersedia']);

    if (result.isNotEmpty) {
      return result[0]['COUNT(*)'] as int;
    } else {
      return 0;
    }
  }

  // Fungsi untuk kamar tidak tersedia
  static Future<int> getJumlahKamarTidaktersedia() async {
    final db = await SQLHelper.db();

    final result = await db.rawQuery(
        'SELECT COUNT(*) FROM kamar WHERE status = ?', ['Tidak Tersedia']);

    if (result.isNotEmpty) {
      return result[0]['COUNT(*)'] as int;
    } else {
      return 0;
    }
  }
}
