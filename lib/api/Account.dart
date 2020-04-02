class Account {
  String id;
  int balance;
  int creditLimit;
  int currencyCode;
  String cashbackType;
  String maskedPan;
  Account(
      {this.id,
      this.balance,
      this.creditLimit,
      this.currencyCode,
      this.cashbackType,
      this.maskedPan});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    creditLimit = json['creditLimit'];
    currencyCode = json['currencyCode'];
    cashbackType = json['cashbackType'];
    List<dynamic> a = json['maskedPan'];
    maskedPan = a[0];
  }
}
