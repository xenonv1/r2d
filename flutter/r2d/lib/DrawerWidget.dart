import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'NavigatorTestRoute.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text("Go Router"),
            onTap: () => context.go('/go-router-screen'),
          ),
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text("Navigator"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => NavigatorTestRoute())));
            },
          ),
        ],
      ),
    );
  }
}
