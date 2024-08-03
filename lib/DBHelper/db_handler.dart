import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zodiac/Models/registration.dart';

class DatabaseHelper {
  static Database? _database;

  // check database create or not
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  // Create New Database
  initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'registration.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // Create Table
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE registration(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      date_of_birth TEXT,
      mobile_number TEXT,
      gender TEXT,
      zodiac_sign TEXT,
      zodiac_sign_image TEXT
    )
  ''');
  }

// Insert New Users Methods
  Future<Registration> insert(Registration registrationModel) async {
    var dbClient = await database;
    await dbClient.insert('registration', registrationModel.toMap());
    return registrationModel;
  }

// Get All Userdata
  Future<List<Registration>> getRegistrationList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient.query('registration');

    return queryResult.map((e) => Registration.fromMap(e)).toList();
  }

  //get user by zodiac name
  Future<List<Registration>> getUsersByZodiacSign(String zodiacSign) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient.query(
      'registration',
      where: 'zodiac_sign = ?',
      whereArgs: [zodiacSign],
    );

    return queryResult.map((e) => Registration.fromMap(e)).toList();
  }

  // get zodiac sign
  Future<List<String>> getDistinctZodiacSigns() async {
    var dbClient = await database;
    final List<Map<String, dynamic>> result = await dbClient.rawQuery(
        "SELECT DISTINCT zodiac_sign FROM registration ORDER BY zodiac_sign");

    return result.map((e) => e['zodiac_sign'] as String).toList();
  }
}
