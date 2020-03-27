import 'package:flutter/material.dart';

class ChoosingWalletCreation extends StatefulWidget {
  @override
  ChoosingWalletCreationState createState() => ChoosingWalletCreationState();
}

class ChoosingWalletCreationState extends State<ChoosingWalletCreation> {

   void add() async{

    final result = await Navigator.pushNamed(context, '/addingWalletPage');
    Navigator.pop(context, result);
  }

  void addLinked() async {
   final result = await Navigator.pushNamed(context, '/addingLinkedWalletPage');
   Navigator.pop(context, result);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("Add wallet", style: TextStyle(fontSize: 24.0),)
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              width: 200.0,
              height: 35.0,
              color: Colors.green,
              child: FlatButton(
                onPressed: add,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white),
                    Text("Main wallet", style: TextStyle(fontSize: 18.0, color: Colors.white))
                  ],
                ),
              ),
            ),
            Text("A wallet where you can \nmanually add operations.", textAlign: TextAlign.center),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              width: 200.0,
              height: 35.0,
              color: Colors.green,
              child: FlatButton(
                onPressed: addLinked,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.link, color: Colors.white),
                    Text("Linked wallet", style: TextStyle(fontSize: 18.0, color: Colors.white))
                  ],
                ),
              ),
            ),
            Text("A wallet which automatically \nsyncs up with bank \noperations.", textAlign: TextAlign.center),
          ],
        )
      ),
    );
  }
}