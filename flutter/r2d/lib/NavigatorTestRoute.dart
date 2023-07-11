import 'package:flutter/material.dart';

class NavigatorTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
        body: const Center(
      child: Text('Second screen'),
      ),
    );
  }
}
