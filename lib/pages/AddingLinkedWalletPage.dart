import 'package:flutter/material.dart';
import 'package:money_project/Wallet.dart';
import 'package:money_project/pages/ChoosingIconForWallet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddingLinkedWalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddingLinkedWalletPageState();
}

class AddingLinkedWalletPageState extends State<AddingLinkedWalletPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  String token;
  double amount;

  IconData icon;

  void chooseIcon() async{

    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosingIconForWallet(),),);

    setState((){
      if(result != null){
        icon = result;
      }
    });

  }

  getWalletAmount() async{
    final response = await http.get('https://api.monobank.ua/personal/client-info', headers: {'X-token': this.token});
    if (response.statusCode == 200)
        print(response.body);
    amount = ((json.decode(response.body) as Map)['accounts'][0]['balance']).toDouble() / 100.0;
    final Wallet result = Wallet(name, amount, icon: icon);
    Navigator.pop(context, result);
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Adding Linked Wallet Page")),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: CircleAvatar(
                            child: Icon(icon == null ? Icons.help_outline : icon),
                            backgroundColor: Colors.green,
                          ),
                          onPressed: chooseIcon,
                        ),
                        labelText: "Wallet name",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Name is Required';
                      } else return null;
                    },
                    onSaved: (String value) {
                      name = value;
                    },
                  )),
              Container(
                padding: EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Personal token",
                      prefixIcon: Icon(Icons.account_box)
                          ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Token is Required';
                    } else return null;
                  },
                  onSaved: (String value) {
                    token = value;
                  }
                ),
              ),
              Container(
                  padding: EdgeInsets.all(6.0),
                  child: Align(
                      child: ButtonTheme(
                        height: 40.0,
                        buttonColor: Colors.grey[300],
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                            child: Text(
                              'Submit',
                            ),
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              getWalletAmount();
                            },
                          )
                      )
                  )
              )
            ],
          ),
        ));
  }
}