import 'package:flutter/material.dart';
import 'package:r2d/CameraInputWidget.dart';
import 'DrawerWidget.dart';
import 'ImageLabeling.dart' as Labler;

import 'dart:typed_data';

String _classificationText = "";
String _labelText = "";
String _additionalInformation = "";
String _informationText = "";

bool _realTimeLabelingToggle = false;

class SightClassificationWidget extends StatelessWidget {
  const SightClassificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sight Classification")),
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          children: const [CameraInputWidget(), ClassificationBody()],
        ),
      ),
    );
  }
}

class ClassificationBody extends StatefulWidget {
  const ClassificationBody({Key? key}) : super(key: key);

  void setLastImage(Uint8List inputImage) {
    _classificationText = Labler.ImageLabeling().labelImage(inputImage);
    checkForLabel();
  }

  void checkForLabel() {
    if (_classificationText.toLowerCase().contains("Musical instrument")) {
      _additionalInformation = "Some kind of object to make music with.";
    } else if (_classificationText.toLowerCase().contains("Plant")) {
      _additionalInformation =
          "Plants are eukaryotes, predominantly photosynthetic, that form the kingdom Plantae.";
    } else if (_classificationText.toLowerCase().contains("Tableware")) {
      _additionalInformation =
          "The knives, forks, spoons, plates, glasses, etc. used for meals";
    } else if (_classificationText.toLowerCase().contains("Room")) {
      _additionalInformation = "A room";
    }
  }

  @override
  State<ClassificationBody> createState() => _ClassificationBodyState();
}

class _ClassificationBodyState extends State<ClassificationBody> {
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
            child: Text(
              _labelText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: SingleChildScrollView(
            child: Text(_informationText),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(
              () {
                onButtonPressed();
              },
            );
          },
          child: Text(
              '${!_realTimeLabelingToggle ? 'Start' : 'Stop'} Image Labeling'),
        ),
      ]),
    );
  }

  void onButtonPressed() async {
    _realTimeLabelingToggle = !_realTimeLabelingToggle;
    while (_realTimeLabelingToggle) {
      setState(() {
        _labelText = _classificationText;
        _informationText = _additionalInformation;
      });
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
