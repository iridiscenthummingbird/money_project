import 'package:flutter/material.dart';
import 'package:money_project/Operation.dart';
import 'package:intl/intl.dart';

import '../Categories.dart';
import 'EditingOperationPage.dart';

class ShowOperationPage extends StatefulWidget {
  final Operation operation;
  ShowOperationPage(this.operation);
  @override
  ShowOperationPageState createState() => ShowOperationPageState(operation);
}

class ShowOperationPageState extends State<ShowOperationPage> {
  Operation operation;
  ShowOperationPageState(this.operation);

  void edit() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditingOperationPage(operation)));
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Operation'),
        actions: <Widget>[IconButton(icon: Icon(Icons.edit), onPressed: edit)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(operation.category.icon),
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.grey[300],
                ),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(operation.category.name,
                        style: TextStyle(
                          fontSize: 24.0,
                        ))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, left: 80),
            child: Text(
              (Categories.outcomeList
                              .indexWhere((i) => i == operation.category) !=
                          -1
                      ? '-'
                      : '+') +
                  operation.amount.toString(),
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Categories.outcomeList
                              .indexWhere((i) => i == operation.category) !=
                          -1
                      ? Colors.red
                      : Colors.green),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.calendar_today, color: Colors.grey)),
                  Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                          DateFormat('dd-MM-yyyy').format(operation.dateTime))),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: CircleAvatar(
                    radius: 15,
                    child: Icon(
                      operation.wallet.icon,
                      size: 18,
                    ),
                    backgroundColor: Colors.green,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(operation.wallet.name,
                        style: TextStyle(fontSize: 18.0)))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(operation.note != null ? Icons.subject : null,
                          color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(operation.note == null ? '' : operation.note),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
