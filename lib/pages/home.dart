import 'package:flutter/material.dart';
import 'package:onigiri/api/firebase/auth.dart';
import 'package:onigiri/models/index.dart';
import 'package:onigiri/pages/index.dart';
import 'package:onigiri/utils/time_format.dart';
import 'package:onigiri/widgets/shared/navigation_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static final String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Order> _userOrders = [];

  @override
  void initState() {
    super.initState();
    Auth.authState().listen((user) {
      if (user == null) {
        print("User is not signed in, redirecting to LoginPage ...");
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
        return;
      }
    });
  }

  Widget _renderHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Your Orders",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 20.0),
        FlatButton.icon(
          textColor: Colors.blue,
          icon: Icon(Icons.add),
          label: Text("Add order"),
          onPressed: () {
            Navigator.of(context).pushNamed(AddOrderPage.routeName);
          },
        )
      ],
    );
  }

  Widget _renderUserOrders() {
    
    _userOrders = [
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
      Order(id: "12-1nf-91b39g1", createdAt: 1601964436),
    ];

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: _userOrders.map((Order order) {
            return Column(
              children: [
                ListTile(
                  leading: Icon(Icons.attach_money),
                  title: Text(TimeFormat.fromEpoch(order.createdAt)),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                Divider(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: NavigationBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: screenWidth * 0.2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderHeader(),
              SizedBox(height: 10.0),
              _renderUserOrders(),
            ],
          ),
        ),
      ),
    );
  }
}
