import 'package:flutter/material.dart';
import 'package:money_project/Wallet.dart';
import 'MyDrawer.dart';

class WalletPage extends StatelessWidget{
  List<Wallet> listOfWallets = [Wallet("Wallet", 500.0), Wallet("Card", 1000.0)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WalletPage"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
              title: Text(listOfWallets[0].name),
              subtitle: Text('\$'+listOfWallets[0].amount.toString()),
              trailing: IconButton(
                onPressed: (){},
                icon: Icon(Icons.menu),
              ),
              leading: CircleAvatar(
                child: Icon(Icons.account_balance_wallet),
                backgroundColor: Colors.green,
              ),
          ),
          ListTile(
              title: Text(listOfWallets[1].name),
              subtitle: Text('\$'+listOfWallets[1].amount.toString()),
              trailing: IconButton(
                onPressed: (){},
                icon: Icon(Icons.menu),
              ),
              leading: CircleAvatar(
                child: Icon(Icons.credit_card),
                backgroundColor: Colors.green,
              ),
          )
        ],
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

}
