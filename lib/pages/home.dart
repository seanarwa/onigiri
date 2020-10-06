import 'package:flutter/material.dart';
import 'package:onigiri/api/firebase/auth.dart';
import 'package:onigiri/pages/index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static final String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Logout"),
              onPressed: Auth.signOut,
            ),
          ],
        ),
      ),
    );
  }
}
