import 'package:flutter/material.dart';
import 'package:money_project/Wallet.dart';
import 'package:money_project/db/database.dart';
import 'package:money_project/iconsList.dart';
import 'package:money_project/pages/ChoosingIconForWallet.dart';

class AddingWalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddingWalletPageState();
}

class AddingWalletPageState extends State<AddingWalletPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  double amount;

  IconData icon = Icons.help_outline;

  void chooseIcon() async{

    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosingIconForWallet(),),);

    setState((){
      if(result != null){
        icon = result;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Adding Wallet Page")),
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
                      labelText: "Wallet amount",
                      prefixIcon: Icon(Icons.keyboard)
                          ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Amount is Required';
                    } else if (double.tryParse(value) == null) {
                      return 'Amount should be number';
                    } else if (double.parse(value) < 0.0) {
                      return 'Amount should be more than 0';
                    } else return null;
                  },
                  onSaved: (String value) {
                    amount = double.parse(value);
                  },
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
                              final Wallet result = Wallet(name, amount, icon: icon);
                              DBProvider.db.insertWal(result);
                              Navigator.pop(context, result);
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
