import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class CameraWidget extends StatelessWidget {
  const CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: const Center(
        child: Text('CameraWidget'),
      ),
    );
  }
}
