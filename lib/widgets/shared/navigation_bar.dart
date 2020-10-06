import 'package:flutter/material.dart';
import 'package:onigiri/api/firebase/auth.dart';

class NavigationBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  NavigationBar({Key key})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Order Onigiri"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.person),
          tooltip: "Profile",
          onPressed: () {
            // TODO: show profile page
          },
        ),
        IconButton(
          icon: Icon(Icons.exit_to_app),
          tooltip: "Sign Out",
          onPressed: Auth.signOut,
        ),
      ],
    );
  }
}
