import 'package:flutter/material.dart';
class show extends StatelessWidget {
  show({@required this.rat,
  this.cat,});

  final rat;
  final cat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(rat),
          Text(cat),
        ],
        
      ),
    );
  }
}