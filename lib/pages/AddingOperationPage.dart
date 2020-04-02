import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_project/Category.dart';
import 'package:money_project/Operation.dart';
import 'package:money_project/db/database.dart';
import 'package:money_project/pages/ChoosingWallet.dart';
import '../Wallet.dart';
import 'ChoosingCategory.dart';

class AddingOperationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddingOperationPageState();
}

class AddingOperationPageState extends State<AddingOperationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double amount;
  Category category;
  String note;
  DateTime date;
  Wallet wallet;

  var txt = TextEditingController();
  var txtDate = TextEditingController();
  var txtWallet = TextEditingController();

  bool isOutcome = true;

  List<Wallet> listOfWallets = [];

  void chooseCategory() async{

    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosingCategory(),),);

    setState((){
      if(result != null){
        category = result;
        txt.text = category.name;
      }
    });
  }

  void chooseWallet() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChoosingWallet(),
      ),
    );

    setState(() {
      if (result != null) {
        wallet = result;
        txtWallet.text = wallet.name;
      }
    });

  }

  DateTime _date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1970),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        _date = picked;
        date = _date;
        txtDate.text = DateFormat('dd-MM-yyyy').format(_date).toString();
      });
    }
  }

  Wallet selectedWallet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adding Operation Page"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              //AMOUNT
              padding:
                  EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 32,
                  ),
                  decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 14),
                      labelText: "Amount",
                      prefixIcon: Icon(Icons.keyboard)),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Amount is Required';
                    } else if (double.tryParse(value) == null) {
                      return 'Amount should be number';
                    } else if (double.parse(value) < 0.0) {
                      return 'Amount should be more than 0';
                    } else
                      return null;
                  },
                  onSaved: (String value) {
                    amount = double.parse(value);
                  }),
            ),
            Container(
              //CATEGORY
              padding:
                  EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                readOnly: true,
                onTap: chooseCategory,
                controller: txt,
                validator: (String value) {
                    if (value.isEmpty) {
                      return 'Category is Required';
                    } else return null;
                  },
                  onSaved: (String val){},
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: "Category",
                    prefixIcon: Icon(
                      category == null ? Icons.help : category.icon,
                      size: 30.0,
                    )),
              ),
            ),
            Container(
              //NOTE
              padding:
                  EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Note",
                    prefixIcon: Icon(Icons.subject, size: 30.0)),
                maxLines: 2,
                onSaved: (String val) {
                  note = val;
                },
              ),
            ),
            Container(
              //DATE
              padding:
                  EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                readOnly: true,
                onTap: () => selectDate(context),
                controller: txtDate,
                validator: (String value) {
                    if (value.isEmpty) {
                      return 'Date is Required';
                    } else return null;
                },
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: "Date",
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      size: 30.0,
                    )),
              ),
            ),
            Container(
              //WALLET
              padding:
                  EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                readOnly: true,
                onTap: chooseWallet,
                validator: (String value) {
                    if (value.isEmpty) {
                      return 'Wallet is Required';
                    } else return null;
                },
                controller: txtWallet,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: "Wallet",
                    prefixIcon: Icon(
                      wallet == null ? Icons.help : wallet.icon,
                      size: 30.0,
                    )),
              ),
            ),
            Container(
                //BUTTON
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
                            if (note.trim() == '') {
                              note = null;
                            }
                            final Operation result = Operation(
                                amount, category, date, wallet,
                                note: note);
                            Navigator.pop(context, result);
                          },
                        ))))
          ],
        ),
      ),
    );
  }
}
