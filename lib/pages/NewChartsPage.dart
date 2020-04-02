import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_project/Indicator.dart';
import 'package:money_project/MyDrawer.dart';
import 'package:money_project/db/database.dart';

import '../Sum.dart';

class NewChartsPage extends StatefulWidget {
  @override
  NewChartsPageState createState() => NewChartsPageState();
}

class NewChartsPageState extends State<NewChartsPage> {
  List<PieChartSectionData> incomeChartList;
  List<PieChartSectionData> outcomeChartList;

  var txtDateFrom = TextEditingController();
  var txtDateTo = TextEditingController();

  double income;
  double outcome;

  String getOutcome() {
    return outcome.toString();
  }

  DateTime dateFrom;
  DateTime dateTo;

  ///////////////////////////////////////////////////////////////// WORK WITH DATE

  void selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateFrom,
        firstDate: DateTime(1970),
        lastDate: dateTo);
    List<Sum> tmp = await DBProvider.db.getStat(dateFrom, dateTo);
    if (picked != null) {
      setState(() {
        dateFrom = picked;
        txtDateFrom.text = DateFormat('dd-MM-yyyy').format(dateFrom).toString();
        income = tmp[1].amount;
        outcome = tmp[0].amount;
      });
    }
  }

  void selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTo,
        firstDate: dateFrom,
        lastDate: DateTime(2100));
    //List<Sum> tmp = await DBProvider.db.getStat(dateFrom, dateTo);
    future = getFuture();
    if (picked != null) {
      setState(() {
        dateTo = DateTime(picked.year, picked.month, picked.day);
        txtDateTo.text = DateFormat('dd-MM-yyyy').format(dateTo).toString();
        //income = tmp[1].amount;
        //outcome = tmp[0].amount;
      });
    }
  }

  ///////////////////////////////////////////////////////////////// WORK WITH AMOUNT
  void setAmountIncome(var list) async {
    List<Sum> l = list;
    income = l[1].amount;
  }

  void setAmountOutcome(var list) async {
    List<Sum> l = list;
    outcome = l[0].amount;
  }

  ///////////////////////////////////////////////////////////////// WORK WITH CHARTS

  void setIncomeChartData(var listF) async {
    List<Sum> list = await listF;
    incomeList = list;
    incomeChartList.clear();
    for (var i in list) {
      incomeChartList.add(PieChartSectionData(
          radius: 80, value: i.amount, title: '', color: i.cat.color));
    }
    setState(() {});
  }

  List<Sum> outcomeList = List<Sum>();
  List<Sum> incomeList = List<Sum>();
  void setOutcomeChartData(var listF) async {
    List<Sum> list = await listF;
    outcomeList = list;
    outcomeChartList.clear();
    for (var i in list) {
      outcomeChartList.add(PieChartSectionData(
          radius: 80,
          value: i.amount,
          title: '', //i.amount.toString(),
          color: i.cat.color));
      setState(() {});
    }
  }

  Future<List<Sum>> outcomeFuture;
  Future<List<Sum>> incomeFuture;
  Future<List<Sum>> future;
  @override
  void initState() {
    dateTo = DateTime.now();
    dateFrom = DateTime(dateTo.year, dateTo.month - 1, dateTo.day);

    txtDateFrom.text = DateFormat('dd-MM-yyyy').format(dateFrom).toString();
    txtDateTo.text = DateFormat('dd-MM-yyyy').format(dateTo).toString();

    outcomeChartList = List<PieChartSectionData>();
    incomeChartList = List<PieChartSectionData>();

    outcomeChartList.add(PieChartSectionData(value: 1));
    incomeChartList.add(PieChartSectionData(value: 1));

    outcomeFuture = getoutcomeFuture();
    incomeFuture = getincomeFuture();

    future = getFuture();

    super.initState();
  }

  Future<List<Sum>> getFuture() async {
    return DBProvider.db.getStat(dateFrom, dateTo);
  }

  Future<List<Sum>> getoutcomeFuture() async {
    return DBProvider.db.getStatDet(1, start: dateFrom, end: dateTo);
  }

  Future<List<Sum>> getincomeFuture() async {
    return DBProvider.db.getStatDet(0, start: dateFrom, end: dateTo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charts'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                width: 150,
                child: TextFormField(
                    controller: txtDateFrom,
                    readOnly: true,
                    onTap: () => selectDateFrom(context),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: "Date from",
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          size: 30.0,
                        ))),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                width: 150,
                child: TextFormField(
                    controller: txtDateTo,
                    readOnly: true,
                    onTap: () => selectDateTo(context),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: "Date to",
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          size: 30.0,
                        ))),
              )
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FutureBuilder(
                  future: future, //DBProvider.db.getStat(dateFrom, dateTo),
                  builder: (context, data) {
                    if (data.connectionState == ConnectionState.done) {
                      setAmountOutcome(data.data);
                      return Text(
                        'Outcome\n${getOutcome()}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      );
                    } else
                      return Text("data");
                  },
                ),
                FutureBuilder(
                  future: future, //DBProvider.db.getStat(dateFrom, dateTo),
                  builder: (context, data) {
                    if (data.connectionState == ConnectionState.done) {
                      setAmountIncome(data.data);
                      return Text(
                        "Income\n${income.toString()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      );
                    } else
                      return Text("data");
                  },
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                  future: incomeFuture,
                  //DBProvider.db.getStatDet(1, start: dateFrom, end: dateTo),
                  builder: (context, list) {
                    if (list.connectionState == ConnectionState.done) {
                      setIncomeChartData(list.data);
                      return Expanded(
                          child: Column(
                        children: <Widget>[
                          PieChart(PieChartData(
                              sectionsSpace: 2,
                              borderData: FlBorderData(show: false),
                              centerSpaceRadius: 0,
                              sections: incomeChartList)),
                          Column(
                              children: incomeList.map((Sum data) {
                            return Container(
                              padding: EdgeInsets.only(bottom: 5, left: 20),
                                child: Indicator(
                                    color: data.cat.color,
                                    text: data.cat.name,
                                    isSquare: true));
                          }).toList())
                        ],
                      ));
                    } else
                      return Text('data');
                  }),
              FutureBuilder(
                  future: outcomeFuture,
                  //DBProvider.db.getStatDet(0, start: dateFrom, end: dateTo),
                  builder: (context, list) {
                    if (list.connectionState == ConnectionState.done) {
                      setOutcomeChartData(list.data);
                      return Expanded(
                          child: Column(
                        children: <Widget>[
                          PieChart(PieChartData(
                              sectionsSpace: 2,
                              borderData: FlBorderData(show: false),
                              centerSpaceRadius: 0,
                              sections: outcomeChartList)),
                              Column(
                              children: outcomeList.map((Sum data) {
                            return Container(
                              padding: EdgeInsets.only(bottom: 5, left: 20),
                                child: Indicator(
                                    color: data.cat.color,
                                    text: data.cat.name,
                                    isSquare: true));
                          }).toList())
                        ],
                      ));
                    } else
                      return Text('data');
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
