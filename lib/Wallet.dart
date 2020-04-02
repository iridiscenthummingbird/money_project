import 'package:flutter/material.dart';
import 'package:money_project/db/database.dart';
import 'package:money_project/iconsList.dart';

class Wallet {
  int id;
  String name;
  double amount;
  IconData icon;
  String token;
  String account;

  Wallet(this.name, this.amount, {this.icon = Icons.account_balance_wallet, this.id, this.token, this.account});

  Map<String, dynamic> toMap(){
    return {
      'id'      : id,
      'name'    : name,
      'amount'  : amount,
      'icon'    : iconsList.indexOf(icon),
      'token'   : token,
      'account' : account
    };
  }

  void fromMap(Map<String, dynamic> map){
    id      = map['id'];
    name    = map['name'];
    amount  = map['amount'];
    icon    = iconsList[map['icon']];
    token   = map['token'];
    account = map['account'];
  }

  void getIdFromDB() async {
    id = await DBProvider.db.getId('Wallets');
  }
}