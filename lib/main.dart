import 'package:flutter/material.dart';
import 'Wallet.dart';
import 'WalletPage.dart';
import 'OperationPage.dart';
import 'User.dart';

 class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => OperationPage(),
        '/walletPage':(context) => WalletPage()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green
      ),
    );
  }
 }



void main(){
  User user = User();

  user.listOfWallets = [
    Wallet("Wallet", 500.0)
  ];
  print(user.listOfWallets);
  runApp(MyApp());
}