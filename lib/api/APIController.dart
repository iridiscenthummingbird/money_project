import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_project/api/CurrencyInfo.dart';
import 'package:money_project/api/StatementItems.dart';
import 'package:money_project/api/UserInfo.dart';

class APIController {
  static String currentToken = 'u3GJtKUmOzZiGU51FlQlGdPLUCGrO7DzQv9zH9gUC7Zo';

  static UserInfo userInfo;

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
    userInfo = UserInfo.fromJson(currenciesJson);
    print(userInfo.accounts[0].maskedPan);
    return res;
  }


  static Future<List<StatementItems>> fetchStatementItems() async{
    var account = userInfo.accounts[0].id;
    int from = 1583020800;
    var url = 'https://api.monobank.ua/personal/statement/$account/$from/';
    print(url);
    String token = 'u3GJtKUmOzZiGU51FlQlGdPLUCGrO7DzQv9zH9gUC7Zo';
    var response = await http.get(url, headers: {'X-Token': token});

    var list = List<StatementItems>();

    if (response.statusCode == 200) {
      var statementsJson = json.decode(response.body);
      for (var statementJson in statementsJson) {
        list.add(StatementItems.fromJson(statementJson));
      }
    }
    else print("error");
    print(list[0].id);
    for (StatementItems i in list) {
      print(i.id.toString() +
          ' ' +
          i.time.toString() +
          ' ' +
          i.description.toString() +
          ' ' +
          i.mcc.toString() +
          ' ' +
          i.hold.toString() +
          ' ' +
          i.amount.toString());
    }

  return list;
    
  }
}

