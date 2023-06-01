import 'package:flutter/material.dart';

import 'DrawerWidget.dart';

class GoRouterRoute extends StatelessWidget {
  const GoRouterRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: const Center(
        child: Text('Go Router route'),
      ),
    );
  }
}
