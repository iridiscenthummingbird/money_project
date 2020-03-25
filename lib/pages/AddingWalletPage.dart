import 'package:flutter/material.dart';
import 'package:money_project/Wallet.dart';
import 'package:validators/validators.dart';

class AddingWalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddingWalletPageState();
}

class AddingWalletPageState extends State<AddingWalletPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  double amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Adding Wallet Page")),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance_wallet),
                        labelText: "Wallet name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Name is Required';
                      }
                    },
                    onSaved: (String value) {
                      name = value;
                    },
                  )),
              Container(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Wallet amount",
                    border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Amount is Required';
                    } else if (double.tryParse(value) == null) {
                      return 'Amount should be number';
                    } else if (double.parse(value) < 0.0) {
                      return 'Amount should be more than 0';
                    }
                  },
                  onSaved: (String value) {
                    amount = double.parse(value);
                  },
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text('Submit'),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  final Wallet result = Wallet(name, amount);
                  Navigator.pop(context, result);
                },
              )
            ],
          ),
        ));
  }
}
