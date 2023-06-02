import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class ObjectClassificationWidget extends StatelessWidget {
  const ObjectClassificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), drawer: DrawerWidget(), body: Center(child: Text('Object Classification'),),);
  }
}
