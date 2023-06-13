import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class TextRecognitionWidget extends StatelessWidget {
  const TextRecognitionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), drawer: DrawerWidget(), body: Center(child: Text('OCR')));
  }
}
