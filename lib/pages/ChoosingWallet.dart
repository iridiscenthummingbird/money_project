import 'package:flutter/material.dart';

import '../Wallet.dart';

class ChoosingWallet extends StatefulWidget {
  @override
  ChoosingWalletState createState() => ChoosingWalletState();
}

class ChoosingWalletState extends State<ChoosingWallet> {

  List<Wallet> listOfWallets = [Wallet("Wallet", 500.0), Wallet("Card", 1000.0, icon: Icons.credit_card)];
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