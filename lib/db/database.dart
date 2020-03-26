import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Transaction{
  final int id;
  String date;
  String wallet;
  double sum;
  double rest;

  Transaction({this.id, this.wallet, this.date, this.sum, this.rest});

  Map<String, dynamic> toMap(){
    return {
      'id'    : id,
      'wallet': wallet,
      'date'  : date,
      'sum'   : sum,
      'rest'  : rest,
    };
  }
}

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");

    return await openDatabase(path, version: 1, 
    onOpen: (db) {}, 
    onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE Wallets(); CREATE TABLE trHistory(id INTEGER PRIMARY KEY, wallet TEXT, date TEXT, sum DOUBLE, rest DOUBLE, info TEXT)"
      );
    });
  }

  Future<void> insertTr(Transaction transaction) async {
    await _database.insert('trHistory', transaction.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }
}



