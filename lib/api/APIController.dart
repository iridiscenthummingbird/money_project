import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_project/Categories.dart';
import 'package:money_project/Operation.dart';
import 'package:money_project/Wallet.dart';
import 'package:money_project/api/CurrencyInfo.dart';
import 'package:money_project/api/StatementItems.dart';
import 'package:money_project/api/UserInfo.dart';
import 'package:money_project/db/database.dart';

class APIController {
  static String currentToken = 'u3GJtKUmOzZiGU51FlQlGdPLUCGrO7DzQv9zH9gUC7Zo';


  static List<Wallet> wallets;

  static Future<List<CurrencyInfo>> fetchCurrencyInfo() async {
    var url = 'https://api.monobank.ua/bank/currency';
    var response = await http.get(url);

    var list = List<CurrencyInfo>();

    if (response.statusCode == 200) {
      var currenciesJson = json.decode(response.body);
      print(currenciesJson.toString() + '\n**********');
      for (var currencyJson in currenciesJson) {
        list.add(CurrencyInfo.fromJson(currencyJson));
      }
    }

    for (CurrencyInfo i in list) {
      print(i.currencyCodeA.toString() +
          ' ' +
          i.currencyCodeB.toString() +
          ' ' +
          i.date.toString() +
          ' ' +
          i.rateSell.toString() +
          ' ' +
          i.rateBuy.toString() +
          ' ' +
          i.rateCross.toString());
    }
    return list;
  }

  static Future<UserInfo> fetchUserInfo() async {
    var url = 'https://api.monobank.ua/personal/client-info';
    String token = 'u3GJtKUmOzZiGU51FlQlGdPLUCGrO7DzQv9zH9gUC7Zo';
    var response = await http.get(url, headers: {'X-Token': token});
    var currenciesJson = json.decode(response.body);
    var res = UserInfo.fromJson(currenciesJson);
    return res;
  }

  static setWallets() async {
    wallets = await DBProvider.db.getWalList(1);
  }

  static Future<List<Operation>> fetchStatementItems() async {

    int from = (DateTime.now().millisecondsSinceEpoch.roundToDouble() * 0.001 -
            2680000.0)
        .toInt();

    var operations = List<Operation>();
    for (Wallet wal in wallets) {
      var url =
          'https://api.monobank.ua/personal/statement/${wal.account}/$from/';
      print(url);
      String token = 'u3GJtKUmOzZiGU51FlQlGdPLUCGrO7DzQv9zH9gUC7Zo';
      var response = await http.get(url, headers: {'X-Token': token});

      var list = List<StatementItems>();

      if (response.statusCode == 200) {
        var statementsJson = json.decode(response.body);
        for (var statementJson in statementsJson) {
          list.add(StatementItems.fromJson(statementJson));
        }
        for (StatementItems i in list) {
          print(i.time * 1000);
          print(DateTime.fromMillisecondsSinceEpoch(i.time * 1000));
          operations.add(Operation(
              i.amount / 100,
              i.amount > 0
                  ? Categories.incomeList[0]
                  : Categories.outcomeList[0],
              DateTime.fromMillisecondsSinceEpoch(i.time * 1000),
              wal,
              note: i.description));
        }
      } else {
        print("error");
        print(response.body);
      }
    }
    return operations;
  }
}
