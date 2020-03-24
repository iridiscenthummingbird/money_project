import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import '../Wallet.dart';

class EditingWalletPage extends StatefulWidget{
  final Wallet wallet;
  EditingWalletPage(this.wallet);
  @override
  State<StatefulWidget> createState() => EditingWalletPageState(wallet);
}

class EditingWalletPageState extends State<EditingWalletPage>{

  final Wallet wallet;

  EditingWalletPageState(this.wallet);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  double amount;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editing Wallet Page")),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Wallet name"),
              initialValue: wallet.name,
              validator: (String value){
                if(value.isEmpty){
                  return 'Name is Required';
                }
              },
              onSaved: (String value){
                name = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Wallet amount"),
              initialValue: wallet.amount.toString(),
              validator: (String value){
                if(value.isEmpty){
                  return 'Amount is Required';
                }
                else if(double.tryParse(value) == null){
                  return 'Amount should be number';
                }
                else if(double.parse(value) < 0.0){
                  return 'Amount should be more than 0';
                }
              },
              onSaved: (String value){
                amount = double.parse(value);
              },
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: (){
                if(!_formKey.currentState.validate()){
                  return;
                }
                _formKey.currentState.save();
                final Wallet result = Wallet(name, amount);
                Navigator.pop(context, result);
              },
            )
          ],
        ),
      )

    );
  }

}