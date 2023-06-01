import "package:flutter/material.dart";

import 'SecondRoute.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.abc),
            title: Text("Page 1"),
          ),
          ListTile(
            leading: Icon(Icons.abc),
            title: Text("Page 2"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => SecondRoute())));
            },
          ),
        ],
      ),
    );
  }
}
