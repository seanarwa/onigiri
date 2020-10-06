import 'package:flutter/material.dart';

class AddOrderPage extends StatefulWidget {
  AddOrderPage({Key key}) : super(key: key);

  static final String routeName = '/order/add';

  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
