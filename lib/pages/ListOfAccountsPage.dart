import 'package:flutter/material.dart';
import 'package:money_project/LinkedWallet.dart';
import 'package:money_project/api/APIController.dart';
import 'package:money_project/api/Account.dart';

class ListOfAccountsPage extends StatefulWidget {
  @override
  ListOfAccountsPageState createState() => ListOfAccountsPageState();
}

class ListOfAccountsPageState extends State<ListOfAccountsPage> {
  List<Account> list = [
    Account(maskedPan: "5375414106649550", balance: 1234),
    Account(maskedPan: "5375414106649550", balance: 13),
    Account(maskedPan: "5375414106649550", balance: 432),
    Account(maskedPan: "5375414106649550", balance: 6547),
  ];

  @override
  void initState() {
    setState(() {
      list = List<Account>();
      APIController.fetchUserInfo().then((value) {
        setState(() {
          list.addAll(value.accounts);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: ListView(
          children: list.map((Account account) {
        return ListTile(
          onTap: () {
            LinkedWallet linkedWallet = LinkedWallet(
                account.maskedPan,
                account.balance.roundToDouble(),
                APIController.currentToken,
                account.id,
                icon: Icons.credit_card);
            Navigator.pop(context, linkedWallet);
          },
          title: Text(account.maskedPan),
          subtitle: Text('\$' + account.balance.toString()),
          leading: CircleAvatar(
            child: Icon(Icons.credit_card),
            backgroundColor: Colors.green,
          ),
        );
      }).toList()),
    );
  }
}
