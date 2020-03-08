import 'package:flutter/material.dart';
import 'MyDrawer.dart';

 class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.green
      ),
    );
  }
 }

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

}

void main(){
  runApp(MyApp());
}