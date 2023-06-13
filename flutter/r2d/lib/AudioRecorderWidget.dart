import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class AudioRecorderWidget extends StatelessWidget {
  const AudioRecorderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), drawer: DrawerWidget(), body: Center(child: Text('Audio Recorder'),),);
  }
}
