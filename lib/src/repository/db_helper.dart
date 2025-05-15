import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static const _dbName = 'audio_files.db';
  static const _dbVersion = 1;

  Database? _db;

  Future<Database> get db async {
    const secure = FlutterSecureStorage();
    String? key = await secure.read(key: 'db_encryption_key');
    if (key == null) {
      key = generateRandomKey();
      await secure.write(key: 'db_encryption_key', value: key);
    }

    if (_db != null) return _db!;
    final path = '${await getDatabasesPath()}/$_dbName';
    _db = await openDatabase(
      path,
      password: key,
      version: _dbVersion,
      onCreate: _onCreate,
    );
    return _db!;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE audio_files (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        path TEXT NOT NULL,
        transcript TEXT NOT NULL,
        importedAt TEXT NOT NULL
      )
    ''');
  }

  String generateRandomKey() {
    final rand = Random.secure();
    final bytes = List<int>.generate(32, (_) => rand.nextInt(256));

    return base64UrlEncode(bytes);
  }
}
