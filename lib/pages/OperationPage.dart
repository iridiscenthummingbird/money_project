import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_project/Categories.dart';
import '../MyDrawer.dart';
import '../Operation.dart';
import '../Wallet.dart';

class OperationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OperationPageState();
}

class OperationPageState extends State<OperationPage> {
  static Wallet wal = Wallet("Card", 123);

  List<Operation> operations = [
    Operation(10.0, Categories.incomeList[1], DateTime(2020, 1, 5), Wallet("Wallet", 500.0), false),
    Operation(20.5, Categories.incomeList[0], DateTime(2020, 2, 3), Wallet("Wallet", 500.0), false),
    Operation(20.5, Categories.outcomeList[1], DateTime(2020, 2, 3), wal, true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Operations"),
      ),
      body: ListView(
          children: operations.map((Operation operation) {
        return ListTile(
          title: Text(operation.category.name),
          subtitle: Text(DateFormat('dd-MM-yyyy').format(operation.dateTime) +
              '\n' +
              operation.wallet.name),
          leading: CircleAvatar(
              child: Icon(operation.category.icon),
              foregroundColor: Colors.green,
              backgroundColor: Colors.grey[300],
          ),
          isThreeLine: true,
          trailing: Text(
            (operation.isOutcome ? '-' : '+') + operation.amount.toString(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: operation.isOutcome ? Colors.red : Colors.green
            ),
          ),
          onTap: () {},
        );
      }).toList()),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("All items");
          for (var item in Categories.incomeList) {
            print("${item.name} - ${item.icon.toString()}");
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
