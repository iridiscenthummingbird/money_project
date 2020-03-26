import 'package:money_project/Category.dart';
import 'package:money_project/Wallet.dart';

class Operation{
  double amount;
  String note;
  Category category;
  DateTime dateTime;
  Wallet wallet;
  bool isOutcome;
  Operation(this.amount, this.category, this.dateTime, this.wallet, this.isOutcome ,[String _note]){
    this.note = _note;
  }
}