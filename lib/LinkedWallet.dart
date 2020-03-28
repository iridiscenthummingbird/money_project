import 'Wallet.dart';

class LinkedWallet extends Wallet {
  String token;
  String account;
  LinkedWallet(name, amount, this.token, this.account, {icon}) : super(name, amount);
}