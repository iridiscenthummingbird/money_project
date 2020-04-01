import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  final String name = "Dmytro Tretiakov";
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.lightGreen[50],
                child: Text(name[0], style: TextStyle(fontSize: 30.0, color: Colors.green),),
                ),
              accountEmail: Text("0508dima@gmail.com"),
              accountName: Text("Dmytro Tretiakov"),
              decoration: BoxDecoration(
                color: Colors.green
              ),
            ),
            ListTile(
              title: Text("Operations"),
              leading: Icon(Icons.credit_card),
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route)=> false);
              },
            ),
            ListTile(
              title: Text("Wallets"),
              leading: Icon(Icons.account_balance_wallet),
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/walletPage', (Route<dynamic> route)=> false);
              },
            ),
            ListTile(
              title: Text("Statistics"),
              leading: Icon(Icons.show_chart),
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/chartPage', (Route<dynamic> route)=> false);
              },
            ),
            Divider(),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
              onTap: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
  }

}