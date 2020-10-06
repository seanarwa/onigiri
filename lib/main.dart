import 'package:flutter/material.dart';
import 'package:onigiri/pages/index.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onigiri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => LoginPage(),
        '/item': (BuildContext context) => ItemPage(),
        '/item/add': (BuildContext context) => AddItemPage(),
        '/order': (BuildContext context) => OrderPage(),
        '/order/add': (BuildContext context) => AddOrderPage(),
      },
    );
  }
}
