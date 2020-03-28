import 'package:flutter/material.dart';
import 'package:money_project/api/APIController.dart';
import 'package:money_project/pages/ListOfAccountsPage.dart';

class TokenInputPage extends StatefulWidget {
  @override
  TokenInputPageState createState() => TokenInputPageState();
}

class TokenInputPageState extends State<TokenInputPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Token"),),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  initialValue: APIController.currentToken,
                  decoration: InputDecoration(
                      labelText: "Token",
                      prefixIcon: Icon(Icons.vpn_key)
                          ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Token is Required';
                    } else return null;
                  },
                  onSaved: (String value) {
                    token = value;
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
                            onPressed: () async{
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();

                              APIController.currentToken = token;

                              var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ListOfAccountsPage()));
                              Navigator.pop(context, result);
                              
                            },
                          )
                      )
                  )
              )
            ],
          )
        ),
      ),
    );
  }
}