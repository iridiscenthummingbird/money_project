import 'package:flutter/material.dart';
import '../iconsList.dart';

class ChoosingIconForWallet extends StatefulWidget {
  @override
  ChoosingIconForWalletState createState() => ChoosingIconForWalletState();
}

class ChoosingIconForWalletState extends State<ChoosingIconForWallet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Icons"),),
      body: GridView.count(
        crossAxisCount: 6,
        children: iconsList.map((IconData icon){
          return IconButton(
            icon: CircleAvatar(
              child: Icon(icon),
              backgroundColor: Colors.green,
            ),
            onPressed: (){
              Navigator.pop(context, icon);
            },
          );
        }).toList()
      ),
    );
  }
}