/*

import 'Wallet.dart';

class LinkedWallet extends Wallet {
  String token;
  String account;
  LinkedWallet(name, amount, this.token, this.account, {icon, id}) : super(name, amount, icon: icon);
  
  @override
  Map<String, dynamic> toMap() {
    Map <String, dynamic> map = super.toMap();
    map['token']    = token;
    map['account']  = account;
    return map;
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    super.fromMap(map);
    token   = map['token'];
    account = map['account'];
  }
}
*/