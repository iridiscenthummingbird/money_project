import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:money_project/MyDrawer.dart';
import '../Wallet.dart';

class ChartsPage extends StatefulWidget {
  @override
  ChartsPageState createState() => ChartsPageState();
}

class Sum {
  String categoryName;
  double amount;
  Sum(this.categoryName, this.amount);
}

class ChartsPageState extends State<ChartsPage> {
  static Wallet wal = Wallet("Card", 123);

  var txtDateFrom = TextEditingController();
  var txtDateTo = TextEditingController();

  DateTime dateFrom;
  DateTime dateTo;

  Future<Null> selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateFrom,
        firstDate: DateTime(1970),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        dateFrom = picked;
        txtDateFrom.text = DateFormat('dd-MM-yyyy').format(dateFrom).toString();
      });
    }
  }

  Future<Null> selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTo,
        firstDate: DateTime(1970),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        dateTo = picked;
        txtDateTo.text = DateFormat('dd-MM-yyyy').format(dateTo).toString();
      });
    }
  }

  List<charts.Series<Sum, String>> _seriesPieData;
  List<charts.Series<Sum, String>> _seriesPieDataOutput;
  _generateData() {
    List<Sum> list = [
      Sum('a', 123),
      Sum('b', 24),
      Sum('c', 41),
      Sum('d', 75),
      Sum('daaaaaaaaaaaaaa', 53),
    ];

    List<Sum> listOutput = [
      Sum('ffffffffffffa', 12),
      Sum('bdddddddddddd', 51),
      Sum('csssssssssgfssssss', 47),
      Sum('cssssssssssadfsssss', 47),
      Sum('cssssssssssdssssss', 47),
      Sum('csssssssssssdssss', 47),
      Sum('daaaaaaaaaaaaaa', 23),
    ];
    _seriesPieDataOutput.add(charts.Series(
      id: "Category amount",
      data: listOutput,
      domainFn: (Sum s, _) => s.categoryName,
      measureFn: (Sum s, _) => s.amount,
      labelAccessorFn: (Sum row, _) => '${row.amount}',
    ));

    _seriesPieData.add(charts.Series(
      id: "Category amount",
      data: list,
      domainFn: (Sum s, _) => s.categoryName,
      measureFn: (Sum s, _) => s.amount,
      labelAccessorFn: (Sum row, _) => '${row.amount}',
    ));
  }

  @override
  void initState() {
    super.initState();
    dateTo = DateTime.now();
    dateFrom = DateTime(dateTo.year, dateTo.month - 1, dateTo.day);


    txtDateFrom.text = DateFormat('dd-MM-yyyy').format(dateFrom).toString();
    txtDateTo.text = DateFormat('dd-MM-yyyy').format(dateTo).toString();

    _seriesPieDataOutput = List<charts.Series<Sum, String>>();
    _seriesPieData = List<charts.Series<Sum, String>>();
    _generateData();
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
                Text("Income\n${1000}", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                Text('Outcome\n${12342}', textAlign: TextAlign.center, style: TextStyle(fontSize: 18))
              ],
            ),
          ),
          Container(
            height: 350,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: charts.PieChart(
                  _seriesPieData,
                  animate: true,
                  animationDuration: Duration(seconds: 1),
                  behaviors: [
                    charts.DatumLegend(
                      position: charts.BehaviorPosition.bottom,
                      horizontalFirst: true,
                      desiredMaxColumns: 1,
                      cellPadding: EdgeInsets.only(right: 4, bottom: 4),
                    )
                  ],
                  defaultRenderer: charts.ArcRendererConfig(
                      arcRendererDecorators: [
                        charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.inside)
                      ]),
                )),
                Expanded(
                    child: charts.PieChart(
                  _seriesPieDataOutput,
                  animate: true,
                  animationDuration: Duration(seconds: 1),
                  behaviors: [
                    charts.DatumLegend(
                      position: charts.BehaviorPosition.bottom,
                      horizontalFirst: true,
                      desiredMaxColumns: 1,
                      cellPadding: EdgeInsets.only(right: 4, bottom: 4),
                    )
                  ],
                  defaultRenderer: charts.ArcRendererConfig(
                      arcRendererDecorators: [
                        charts.ArcLabelDecorator(
                            labelPosition: charts.ArcLabelPosition.inside)
                      ]),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
