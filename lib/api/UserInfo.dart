import 'package:money_project/api/Account.dart';

class UserInfo{
  String name;
  List<Account> accounts;

  UserInfo({this.name, this.accounts});

  UserInfo.fromJson(Map<String, dynamic> _json){
    name = _json['name'];
    var accountsJson = _json['accounts'];
    accounts = List<Account>();
    for (var accountJson in accountsJson) {
      accounts.add(Account.fromJson(accountJson));
    }
  }
}