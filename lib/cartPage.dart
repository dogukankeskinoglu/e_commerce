import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }

  AppBar appBar() => AppBar(
        title: Text(
          "Cart Page",
          style: TextStyle(color: Colors.blue.shade900),
        ),
        centerTitle: true,
        actions: [Icon(Icons.favorite)],
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue.shade900),
        elevation: 0,
      );
}
