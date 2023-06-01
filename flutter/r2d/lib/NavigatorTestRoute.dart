import 'package:flutter/material.dart';

class NavigatorTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
        body: Center(
      child: Text('Second screen'),
      ),
    );
  }
}
