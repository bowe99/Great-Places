import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(
        dbPath,
        'userplaces.db',
      ),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL)');
      },
      version: 1
    );

  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDB = await DBHelper.database();

    await sqlDB.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDB = await DBHelper.database();
    return sqlDB.query(table);
  }
}
