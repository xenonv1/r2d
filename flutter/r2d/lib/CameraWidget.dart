import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class CameraWidget extends StatelessWidget {
  const CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(),
      body: Center(
        child: Text('CameraWidget'),
      ),
    );
  }
}
