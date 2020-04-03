import 'package:flutter/material.dart';
import 'package:money_project/Category.dart';

class Categories{
  static List<Category> incomeList = [
    Category('Others', Icons.archive, color: Colors.red),
    Category('Salary', Icons.attach_money, color: Colors.green),
    Category('Gifts', Icons.card_giftcard, color: Colors.blue)

  ];
  static List<Category> outcomeList = [
    Category('Other', Icons.archive, color: Colors.amber),
    Category('Pharmasy', Icons.local_pharmacy, color: Colors.green),
    Category('Food', Icons.local_pizza, color: Colors.red),
    Category('Travel', Icons.airplanemode_active, color: Colors.blue),
    Category('Transportation', Icons.directions_bus, color: Colors.brown),
    Category('Bill', Icons.description, color: Colors.yellow),
    Category('Shopping', Icons.shopping_cart, color: Colors.orange),
    Category('Friends & Lover', Icons.favorite, color: Colors.pink),
    Category('Family', Icons.home, color: Colors.black),
    Category('Gifts & donations', Icons.favorite_border, color: Colors.brown),
    Category('Education', Icons.book, color: Colors.cyan),
    Category('Investiment', Icons.show_chart, color: Colors.purple),
    Category('Buisness', Icons.business_center, color: Colors.lime),
  ];
}