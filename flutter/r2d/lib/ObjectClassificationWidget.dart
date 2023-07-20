import 'package:flutter/material.dart';
import 'package:r2d/CameraInputWidget.dart';
import 'DrawerWidget.dart';
import 'ImageLabeling.dart' as Labler;

import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

String _classificationText = "";
String _labelText = "";

bool _realTimeLabelingToggle = false;

class ObjectClassificationWidget extends StatelessWidget {
  const ObjectClassificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Object Classification")),
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          children: const [CameraInputWidget(), ImageLabeling()],
        ),
      ),
    );
  }
}

class ImageLabeling extends StatefulWidget {
  const ImageLabeling({Key? key}) : super(key: key);

  void setLastImage(Uint8List inputImage) {
    _classificationText = Labler.ImageLabeling().labelImage(inputImage);
  }

  @override
  State<ImageLabeling> createState() => _ImageLabelingState();
}

class _ImageLabelingState extends State<ImageLabeling> {
  @override
  void initState() {
    const CameraInputWidget().toggleLabeling();
    super.initState();
  }

  @override
  void dispose() {
    const CameraInputWidget().toggleLabeling();
    _realTimeLabelingToggle = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 15),
        SizedBox(
            height: 300,
            child: SingleChildScrollView(
                child: Text(_labelText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold)))),
        ElevatedButton(
            onPressed: () {
              setState(
                () {
                  onButtonPressed();
                },
              );
            },
            child: Text(
                '${!_realTimeLabelingToggle ? 'Start' : 'Stop'} Image Labeling')),
      ]),
    );
  }

  void onButtonPressed() async {
    _realTimeLabelingToggle = !_realTimeLabelingToggle;
    while (_realTimeLabelingToggle) {
      setState(() {
        _labelText = _classificationText;
      });
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
