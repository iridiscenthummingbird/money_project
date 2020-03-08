import 'package:flutter/material.dart';
import 'MyDrawer.dart';

class WalletPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WalletPage"),
      ),
      body: Center(
        child: Text("WalletPage")
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
