import 'dart:io';
import 'dart:async';

import 'package:money_project/Categories.dart';
import 'package:money_project/iconsList.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Category.dart';
import '../Sum.dart';
import '../Wallet.dart';
import '../Operation.dart';

/*
class Operation{
  final int id;
  String date;
  String wallet;
  double sum;
  double rest;

  Operation({this.id, this.wallet, this.date, this.sum, this.rest});

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
*/

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");

    return await openDatabase(path, version: 1, 
    onOpen: (db) {
     db.execute(
      'PRAGMA foreign_keys = ON;'
     );
    }, 
    onCreate: (Database db, int version) async {
      await db.execute(
        '''
        CREATE TABLE Wallets(
          id INT PRIMARY KEY,
          name TEXT,
          amount DOUBLE,
          icon INT,
          token TEXT,
          account TEXT
        );
        '''
      );

      await db.execute(
        '''
        CREATE TABLE Operations(
          id INT PRIMARY KEY,
          opID INT,
          amount DOUBLE,
          balance DOUBLE,
          catType INT,
          catInd INT,         
          date TEXT,
          wallet INT REFERENCES Wallets(id) ON DELETE CASCADE,
          note TEXT
        );
        '''    
      );
    });
  }


//-------------------------------------------------------------------------------------------------------------
//                                           Операции с кошельками
//-------------------------------------------------------------------------------------------------------------


  Future <void> insertWal(Wallet wallet) async {
    final db = await database;
    wallet.id = await DBProvider.db.getId('Wallets');
    await db.insert('Wallets', wallet.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future <void> deleteWal(Wallet wallet) async {
    final db = await database;
    await db.delete('Wallets', where: 'id = ?', whereArgs: [wallet.id]);
  }

  Future <void> updateWal(Wallet wallet) async {
    final db = await database;
    await db.update('Wallets', wallet.toMap(), where: 'id = ?', whereArgs: [wallet.id]);
  }

  Future<List<Wallet>> getWalList([int link]) async {
    final db = await database;
    List<Map<String, dynamic>> maps = [];
    List<Wallet> tmp = [];

    if (link == 1)
      maps = await db.query('Wallets', where: 'token IS NOT NULL');
    else if(link == 0)
      maps = await db.query('Wallets', where: 'token IS NULL');
    else
      maps = await db.query('Wallets');
    
    if (maps.isEmpty) return [];

    tmp = List.generate(maps.length, (i) {
        return Wallet(
                            maps[i]['name'],
                            maps[i]['amount'],
        id:                 maps[i]['id'],          
        icon:     iconsList[maps[i]['icon']],
        account:            maps[i]['account'],
        token:              maps[i]['token']        
        );
    } // (i)
    );

    return tmp;
  }

  Future<Wallet> getWalByIdFromDB(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Wallets', where: 'id = ?', whereArgs: [id]);

    List <Wallet> tmp =  List.generate(maps.length, (i){
        return Wallet(
                          maps[i]['name'],
                          maps[i]['amount'],
        id:               maps[i]['id'],          
        icon:   iconsList[maps[i]['icon']],
        account:          maps[i]['account'],
        token:            maps[i]['token']          
        );
      }
    );

    return tmp[0];
  }


//-------------------------------------------------------------------------------------------------------------
//                                           Операции с операциями                                             
//-------------------------------------------------------------------------------------------------------------


  Future <void> insertOp(Operation operation) async {
    final db = await database;
    operation.dbID = await DBProvider.db.getId('Operations');
    await db.insert('Operations', operation.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    if (Categories.incomeList.indexOf(operation.category) == -1)
      await db.rawUpdate('UPDATE Wallets SET amount = amount - ? WHERE Wallets.id = ?;', [operation.amount, operation.wallet.id]);
    else 
      await db.rawUpdate('UPDATE Wallets SET amount = amount + ? WHERE Wallets.id = ?;', [operation.amount, operation.wallet.id]);
  }

  Future<void> deleteOp(Operation operation) async {
    final db = await database;
    await db.delete('Operations', where: '"id" = ?', whereArgs: [operation.dbID]);
  }

  Future<void> updateOp(Operation operation) async {
    final db = await database;
    await db.update('Operations', operation.toMap(), where: 'id = ?', whereArgs: [operation.dbID]);
  }

  Future<List<Operation>> getOpList() async {
    final db = await database;
    final List<Map<String, dynamic>> oper = await db.query('Operations');
    final List<Map<String, dynamic>> wals = await db.query('Wallets');

    if (oper.isEmpty) return [];


    List <Wallet> wList = List.generate(wals.length, (i){
        return Wallet(
                              wals[i]['name'],
                              wals[i]['amount'],
          token:              wals[i]['token'],
          account:            wals[i]['account'],
          id:                 wals[i]['id'],  
          icon:     iconsList[wals[i]['icon']] 
        );
      }
    );

    List <Operation> oList = List.generate(oper.length, (i){
      int cat = oper[i]['catType'], index = oper[i]['catInd'];
      Category temp; cat == 1 ? temp = Categories.incomeList[index] : temp = Categories.outcomeList[index];

        return Operation(
                  oper[i]['amount'],
                  temp,
                  DateTime.parse(oper[i]['date']),
                  wList.firstWhere( (w) => w.id == oper[i]['wallet'] ),
        note:     oper[i]['note'],
        balance:  oper[i]['balance'],
        opID:     oper[i]['opID'],
        dbID:     oper[i]['id']
        );
    }
    );

    return oList;
  }


//-------------------------------------------------------------------------------------------------------------
//                                   Функции для работы со статистикой                                             
//-------------------------------------------------------------------------------------------------------------

  Future <List<Sum>> getStatDet(int cat, {DateTime start, DateTime end}) async {
    final db = await database;
    if (start == null || end == null) { start = DateTime.parse('2000-01-01T00:00:00'); end = DateTime.now(); }

    List <Map <String, dynamic>> stat = await db.rawQuery(
    '''
    SELECT catInd, SUM(Operations.amount) AS amountSum FROM Operations WHERE catType = ? AND datetime(Operations.date) BETWEEN datetime(?) AND datetime(?) GROUP BY catInd ORDER BY amountSum DESC;
    ''',
    [cat, start.toIso8601String().substring(0, 19), end.toIso8601String().substring(0, 19)]
    );

    return List.generate(stat.length, (i){
        Category cate; double amount;
        cat == 0 ? cate = Categories.outcomeList[stat[i]['catInd']] : cate = Categories.incomeList[stat[i]['catInd']];
        amount = stat[i]['amountSum'];

        return Sum(
          amount,
          cat: cate
        );
      }
    );
  }

  Future <List <Sum>> getStat([DateTime start, DateTime end]) async {
    final db = await database;
    if (start == null || end == null) { start = DateTime.parse('2000-01-01T00:00:00'); end = DateTime.now(); }
    
    List <Map <String, dynamic>> maps = await db.rawQuery(
    '''
    SELECT SUM(Operations.amount) AS amountSum FROM Operations WHERE datetime(Operations.date) BETWEEN datetime(?) AND datetime(?) GROUP BY catType ORDER BY amountSum DESC;
    ''',
    [start.toIso8601String().substring(0, 19), end.toIso8601String().substring(0, 19)]
    );

    List <Sum> res = [];
    res.add( Sum(maps[0]['amountSum']));
    res.add( Sum(maps[1]['amountSum']));

    return res;
  }



//-------------------------------------------------------------------------------------------------------------
//                                        Функции для работы с БД                                             
//-------------------------------------------------------------------------------------------------------------


  Future<void> dropDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, "TestDB.db");
    deleteDatabase(path);
  }

  Future<int> getId(String table) async {
    final db = await database;
    List<Map> tmp = await db.rawQuery('SELECT MAX("id") AS id FROM ' + table);
    return tmp[0]['id'] == null ? 1 : tmp[0]['id'] + 1;
  }

  Future<void> exec(String sql) async {
    final db = await database;
    db.execute(sql);
  }

  void test() {
    print("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-");
    //dropDB();
    //print(await getWalList());
    print("-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-");
  }

}



