import 'package:flutter/material.dart';

class ChoosingIconForWallet extends StatefulWidget {
  @override
  ChoosingIconForWalletState createState() => ChoosingIconForWalletState();
}

class ChoosingIconForWalletState extends State<ChoosingIconForWallet> {
  List<IconData> icons = [
    Icons.account_balance_wallet,
    Icons.credit_card,
    Icons.album,
    Icons.beach_access,
    Icons.brush,
    Icons.build,
    Icons.cake,
    Icons.business_center,
    Icons.child_friendly,
    Icons.chrome_reader_mode,
    Icons.class_ ,
    Icons.cloud,
    Icons.color_lens,
    Icons.directions_bike,
    Icons.directions_bus,
    Icons.directions_boat,
    Icons.directions_car,
    Icons.directions_railway,
    Icons.domain,
    Icons.email,
    Icons.euro_symbol,
    Icons.ev_station,
    Icons.fastfood,
    Icons.fitness_center,
    Icons.flight,
    Icons.free_breakfast,
    Icons.gavel,
    Icons.hotel,
    Icons.account_balance,
    Icons.home,
    Icons.kitchen,
    Icons.work,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Icons"),),
      body: GridView.count(
        crossAxisCount: 6,
        children: icons.map((IconData icon){
          return IconButton(
            icon: CircleAvatar(
              child: Icon(icon),
              backgroundColor: Colors.green,
            ),
            onPressed: (){
              Navigator.pop(context, icon);
            },
          );
        }).toList()
      ),
    );
  }
}