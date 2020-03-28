import 'package:flutter/material.dart';
import 'package:money_project/pages/AddingOperationPage.dart';
import 'package:money_project/pages/AddingWalletPage.dart';
import 'pages/ChoosingWalletCreation.dart';
import 'pages/WalletPage.dart';
import 'pages/OperationPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => OperationPage(),
        '/walletPage': (context) => WalletPage(),
        '/addingWalletPage': (context) => AddingWalletPage(),
        '/addingOperationPage': (context) => AddingOperationPage(),
        '/choosingWalletCreation': (context) => ChoosingWalletCreation()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
    );
  }
}

void main() {
  runApp(MyApp());
}
