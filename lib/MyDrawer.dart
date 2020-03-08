import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                ),
              accountEmail: Text("0508dima@gmail.com"),
              accountName: Text("Dmytro Tretiakov"),
              decoration: BoxDecoration(
                color: Colors.green
              ),
            ),
            ListTile(
              title: Text("Operations"),
              leading: Icon(Icons.account_balance_wallet),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Statistics"),
              leading: Icon(Icons.show_chart),
              onTap: (){
                Navigator.pop(context);
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