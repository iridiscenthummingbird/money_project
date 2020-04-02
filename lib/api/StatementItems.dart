class StatementItems{
  String id;
  int time;
  String description;
  int mcc;
  bool hold;
  int amount;
  int operationAmount;
  int currencyCode;
  int commissionRate;
  int cashbackAmount;
  int balance;

  StatementItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    description = json['description'];
    mcc = json['mcc'];
    hold = json['hold'];
    amount = json['amount'];
    operationAmount = json['operationAmount'];
    currencyCode = json['currencyCode'];
    commissionRate = json['commissionRate'];
    cashbackAmount = json['cashbackAmount'];
    balance = json['balance'];
  }
}