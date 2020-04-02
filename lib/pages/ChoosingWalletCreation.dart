import 'package:flutter/material.dart';
import 'package:money_project/pages/TokenInputPage.dart';
import 'package:url_launcher/url_launcher.dart';

class ChoosingWalletCreation extends StatefulWidget {
  @override
  ChoosingWalletCreationState createState() => ChoosingWalletCreationState();
}

class ChoosingWalletCreationState extends State<ChoosingWalletCreation> {

  void add() async {
    final result = await Navigator.pushNamed(context, '/addingWalletPage');
    Navigator.pop(context, result);
  }

  void addLinked() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TokenInputPage()));
    Navigator.pop(context);
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
              child: Text(
            "Add wallet",
            style: TextStyle(fontSize: 24.0),
          )),
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
                  Text("Main wallet",
                      style: TextStyle(fontSize: 18.0, color: Colors.white))
                ],
              ),
            ),
          ),
          Text("A wallet where you can \nmanually add operations.",
              textAlign: TextAlign.center),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            width: 200.0,
            height: 35.0,
            color: Colors.green,
            child: FlatButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Token"),
                          content: Text(
                              "Copy your token on https://api.monobank.ua"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Back'),
                            ),
                            FlatButton(
                              child: Text('Go to website'),
                              onPressed: () async {
                                const String url = "https://api.monobank.ua/";
                                if (await canLaunch(url)) {
                                  launch(url);
                                  addLinked();
                                }
                              },
                            )
                          ],
                        ),
                    barrierDismissible: false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.link, color: Colors.white),
                  Text("Linked wallet",
                      style: TextStyle(fontSize: 18.0, color: Colors.white))
                ],
              ),
            ),
          ),
          Text(
              "A wallet which automatically \nsyncs up with bank \noperations.",
              textAlign: TextAlign.center),
        ],
      )),
    );
  }
}

