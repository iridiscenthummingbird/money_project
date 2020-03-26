import 'package:money_project/Category.dart';
import 'package:money_project/Wallet.dart';

class Operation{
  double amount;
  String note;
  Category category;
  DateTime dateTime;
  Wallet wallet;
  double balance;
  Operation(this.amount, this.category, this.dateTime, this.wallet ,{this.note, this.balance});
}