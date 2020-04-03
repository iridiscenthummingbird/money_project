import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_project/Operation.dart';
import 'package:money_project/db/database.dart';
import 'ChoosingCategory.dart';

class EditingOperationPage extends StatefulWidget {
  final Operation operation;
  EditingOperationPage(this.operation);
  @override
  EditingOperationPageState createState() =>
      EditingOperationPageState(operation);
}

class EditingOperationPageState extends State<EditingOperationPage> {
  static Operation operation;
  EditingOperationPageState(var val) {
    operation = val;
  }

  var txtCat = TextEditingController();
  var txtNote = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void chooseCategory() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChoosingCategory(),
      ),
    );

    setState(() {
      if (result != null) {
        operation.category = result;
        txtCat.text = operation.category.name;
      }
    });
  }

  @override
  void initState() {
    setState(() {
      txtCat.text = operation.category.name;
      txtNote.text = operation.note;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editing Operation"),
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
                readOnly: true,
                initialValue: operation.amount.toString(),
                style: TextStyle(
                  fontSize: 32,
                ),
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: "Amount",
                    prefixIcon: Icon(Icons.keyboard)),
              ),
            ),
            Container(
              //CATEGORY
              padding:
                  EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: txtCat,
                readOnly: true,
                onTap: chooseCategory,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: "Category",
                    prefixIcon: Icon(
                      operation.category.icon,
                      size: 30.0,
                      color: Colors.green,
                    )),
              ),
            ),
            Container(
              //NOTE
              padding:
                  EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: txtNote,
                decoration: InputDecoration(
                    labelText: "Note",
                    prefixIcon: Icon(Icons.subject, size: 30.0)),
                maxLines: 2,
                onSaved: (String val) {
                  operation.note = val;
                },
              ),
            ),
            Container(
              //DATE
              padding:
                  EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                initialValue: DateFormat('dd-MM-yyyy')
                    .format(operation.dateTime)
                    .toString(),
                readOnly: true,
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
                initialValue: operation.wallet.name,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: "Wallet",
                    prefixIcon: Icon(
                      operation.wallet.icon,
                      size: 30.0,
                      color: Colors.green,
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
                            if (operation.note.trim() == '') {
                              operation.note = null;
                            }
                            DBProvider.db.updateOp(operation);
                            Navigator.pop(context, operation);
                          },
                        ))))
          ],
        ),
      ),
    );
  }
}
