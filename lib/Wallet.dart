import 'package:flutter/material.dart';

class Wallet{
  String name;
  double amount;
  IconData icon;
  Wallet(this.name, this.amount, {this.icon = Icons.account_balance_wallet});
}