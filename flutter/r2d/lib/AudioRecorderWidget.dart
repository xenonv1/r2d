import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class AudioRecorderWidget extends StatelessWidget {
  const AudioRecorderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), drawer: const DrawerWidget(), body: const Center(child: Text('Audio Recorder'),),);
  }
}
