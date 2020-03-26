import 'package:flutter/material.dart';
import 'package:money_project/Wallet.dart';
import '../MyDrawer.dart';
import 'EditingWalletPage.dart';

class WalletPage extends StatefulWidget{
  @override
  WalletPageState createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage>{
  List<Wallet> listOfWallets = [Wallet("Wallet", 500.0), Wallet("Card", 1000.0, icon: Icons.credit_card)];
  
  void delete(dynamic val){
    setState(() => listOfWallets.removeWhere((data) => data == val));
  }
  
  void edit(dynamic val) async{
    int ind = listOfWallets.indexOf(val);

    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditingWalletPage(val),),);

    setState((){
      if(result != null){
      listOfWallets.replaceRange(ind, ind+1, [result]);
      }
    });
  }

  void add() async{

    final result = await Navigator.pushNamed(context, '/choosingWalletCreation');

    setState(() {
      if(result != null){
        listOfWallets.add(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WalletPage"),
      ),
      body: ListView(
        children: listOfWallets.map((Wallet wallet){
          return ListTile(
            title: Text(wallet.name),
            subtitle: Text('\$'+wallet.amount.toString()),
            trailing: PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: (val){
                if(val[1] == 'delete'){
                  delete(val[0]);
                }
                else if(val[1] == 'edit'){
                  edit(val[0]);
                }
              },
              icon: Icon(Icons.menu), 
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: [wallet, 'edit'],
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  ),
                ),
                PopupMenuItem(
                  value: [wallet, 'delete'],
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                ),
              ],
            ),
            leading: CircleAvatar(
              child: Icon(wallet.icon),
              backgroundColor: Colors.green,
            )
          );
        }).toList()
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}