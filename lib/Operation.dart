import 'package:money_project/Category.dart';
import 'package:money_project/Wallet.dart';
import 'package:money_project/db/database.dart';
import 'Categories.dart';

class Operation {
	int 				dbID;
  double      amount;
  String      note;
  Category    category;
  String      opID;
  DateTime    dateTime;
  Wallet      wallet;
  double      balance;

  Operation(this.amount, this.category, this.dateTime, this.wallet, {this.note, this.balance, this.opID, this.dbID}){
    if (this.balance == null) if (this.wallet.token == null) Categories.incomeList.indexOf(category) == -1 ? this.balance = this.wallet.amount - this.amount : this.balance = this.wallet.amount + this.amount;
  }

  Map<String, dynamic> toMap(){
    int cat;
    int index = Categories.incomeList.indexOf(category);
    String dat = dateTime.toIso8601String().substring(0, 19);

    if (index != -1) cat = 1; 
    else {
      index = Categories.outcomeList.indexOf(category);
      cat = 0;
    }

    return {
			'id'			: dbID,
      'amount'  : amount,
      'note'    : note,
      'catType' : cat,
      'catInd'  : index,
      'date'    : dat,
      'wallet'  : wallet.id,
      'balance' : balance,
      'opID'    : opID
    };
  }

  void fromMap(Map<String, dynamic> map){
    dbID			= map['id'];
    amount    = map['amount'];
    note      = map['note'];
    dateTime  = DateTime.parse(map['dateTime']);
    _getWalletByID(map['wallet']);
    balance   = map['balance'];
    opID      = map['opID'];

    int cat = map['catType'];
    cat == 1 ? category = Categories.incomeList[map['catInd']] : category = Categories.outcomeList[map['catInd']];
  }

  Future<Wallet> _getWalletByID(int id) async {
    return await DBProvider.db.getWalByIdFromDB(id);
  }
}