import 'package:flutter/material.dart';
import 'package:money_project/Categories.dart';
import 'package:money_project/Category.dart';

class ChoosingCategory extends StatefulWidget {
  @override
  ChoosingCategoryState createState() => ChoosingCategoryState();
}

class ChoosingCategoryState extends State<ChoosingCategory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Categories"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Outcome',
                ),
                Tab(
                  text: 'Income',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListView(
                children: Categories.outcomeList.map((Category category) {
                  return ListTile(
                    onTap: (){
                      Navigator.pop(context, category);
                    },
                    title: Text(category.name),
                    leading: CircleAvatar(
                      child: Icon(category.icon),
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.grey[300],
                    ),
                  );
                }).toList(),
              ),
              ListView(
                children: Categories.incomeList.map((Category category) {
                  return ListTile(
                    onTap: (){
                      Navigator.pop(context, category);
                    },
                    title: Text(category.name),
                    leading: CircleAvatar(
                      child: Icon(category.icon),
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.grey[300],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ));
  }
}
