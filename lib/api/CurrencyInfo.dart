class CurrencyInfo {
  int currencyCodeA;
  int currencyCodeB;
  int date;
  double rateSell;
  double rateBuy;
  double rateCross;
  
  CurrencyInfo(
      {this.currencyCodeA,
      this.currencyCodeB,
      this.date,
      this.rateSell,
      this.rateBuy,
      this.rateCross});

  CurrencyInfo.fromJson(Map<String, dynamic> json) {
    currencyCodeA = json['currencyCodeA'];
    currencyCodeB = json['currencyCodeB'];
    date = json['date'];
    rateSell = json['rateSell'];
    rateBuy = json['rateBuy'];
    rateCross = json['rateCross'];
  }
}