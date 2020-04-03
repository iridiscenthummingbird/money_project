import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_project/Categories.dart';
import 'package:money_project/api/APIController.dart';
import 'package:money_project/pages/ShowOperationPage.dart';
import '../MyDrawer.dart';
import '../Operation.dart';
import '../Wallet.dart';
import '../db/database.dart';

class OperationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OperationPageState();
}

class OperationPageState extends State<OperationPage> {
  static Wallet wal = Wallet("Card", 123);

  List<Operation> operations = [];


/*

  Operation(110.0, Categories.incomeList[1], DateTime(2020, 1, 5),
        Wallet("Wallet", 500.0)),
  Operation(20.5, Categories.incomeList[0], DateTime(2020, 2, 3),
        Wallet("Wallet", 500.0)),
  Operation(20.5, Categories.outcomeList[1], DateTime(2020, 2, 3), wal),
*/


  void add() async {
    var result = await Navigator.pushNamed(context, '/addingOperationPage');

    setState(() {
      if (result != null) {
        operations.add(result);
      }
    });
  }

  void getListOfOperations() async {
    operations = await DBProvider.db.getOpList();
    setState(() { });
  }


  Future<Null> getrefresh() async{
    return APIController.fetchStatementItems().then((List<Operation> list){
      for(var i in list){
        DBProvider.db.insertOp(i);
      }
      operations.addAll(list);
      operations.sort((a,b)=> a.dateTime.isBefore(b.dateTime) ? 1 : 0);
      setState(() {
        
      });
    });
  }


  @override
  void initState() {
    getListOfOperations();
    //DBProvider.db.test();
    operations.sort((a,b)=> a.dateTime.isBefore(b.dateTime) ? 1 : 0);
    APIController.setWallets();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Operations"),
      ),
      body: RefreshIndicator (
        onRefresh: getrefresh,
       child: ListView(
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
            (Categories.outcomeList
                            .indexWhere((i) => i == operation.category) !=
                        -1
                    ? '-'
                    : '+') +
                operation.amount.toString(),
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Categories.outcomeList
                            .indexWhere((i) => i == operation.category) !=
                        -1
                    ? Colors.red
                    : Colors.green),
          ),
          onTap: () async {
            final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowOperationPage(operation)));
            int ind = operations.indexOf(operation);

            if (result != null) {
              setState(() {
                operations.replaceRange(ind, ind + 1, [result]);
              });
            }
          },
        );
      }).toList())),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          add();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
