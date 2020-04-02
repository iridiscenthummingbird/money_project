import 'package:flutter/material.dart';

import '../db/database.dart';
import '../Wallet.dart';

class ChoosingWallet extends StatefulWidget {
  @override
  ChoosingWalletState createState() => ChoosingWalletState();
}

class ChoosingWalletState extends State<ChoosingWallet> {

  List<Wallet> listOfWallets = [];

  void getListOfWallets() async {
    listOfWallets       = await DBProvider.db.getWalList(0);
    setState(() { });
  }

  @override
  void initState(){
    getListOfWallets();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallets'),
      ),
      body: ListView(
        children: listOfWallets.map((Wallet wallet){
          return ListTile(
            title: Text(wallet.name),
            subtitle: Text(wallet.amount.toString()),
            leading: CircleAvatar(
              child: Icon(wallet.icon),
              backgroundColor: Colors.green,
            ),
            onTap: (){
              Navigator.pop(context, wallet);              
            },
          );
        }).toList(),
      ),
    );
  }
}