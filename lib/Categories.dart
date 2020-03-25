import 'package:flutter/material.dart';
import 'package:money_project/Category.dart';

class Categories{
  static List<Category> incomeList = [
    Category('Salary', Icons.business_center),
    Category('Others', Icons.attach_money),
    Category('Gifts', Icons.card_giftcard)

  ];
  static List<Category> outcomeList = [
    Category('Pharmasy', Icons.local_pharmacy),
    Category('Food', Icons.fastfood)
  ];
}