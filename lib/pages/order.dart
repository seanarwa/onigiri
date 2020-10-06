import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  static final String routeName = '/order';

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
