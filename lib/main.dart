import 'package:flutter/material.dart';
import 'WalletPage.dart';
import 'OperationPage.dart';

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
  
  runApp(MyApp());
}