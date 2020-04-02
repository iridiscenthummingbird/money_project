import 'package:flutter/material.dart';
import 'package:money_project/Category.dart';

class Categories{
  static List<Category> incomeList = [
    Category('Salary', Icons.attach_money),
    Category('Others', Icons.archive),
    Category('Gifts', Icons.card_giftcard)

  ];
  static List<Category> outcomeList = [
    Category('Pharmasy', Icons.local_pharmacy),
    Category('Food', Icons.local_pizza),
    Category('Travel', Icons.airplanemode_active),
    Category('Transportation', Icons.directions_bus),
    Category('Bill', Icons.description),
    Category('Shopping', Icons.shopping_cart),
    Category('Friends & Lover', Icons.favorite),
    Category('Family', Icons.home),
    Category('Gifts & donations', Icons.favorite_border),
    Category('Education', Icons.book),
    Category('Investiment', Icons.show_chart),
    Category('Buisness', Icons.business_center),
    Category('Other', Icons.archive)
  ];
}