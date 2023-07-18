import 'package:flutter/material.dart';

import 'DrawerWidget.dart';
import 'CameraInputWidget.dart';
import 'ImageLabeling.dart';

class SightClassificationWidget extends StatelessWidget {
  const SightClassificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sight Classification'),
      ),
      drawer: const DrawerWidget(),
      body: ClassificationBody(),
    );
  }
}

class ClassificationBody extends StatefulWidget {
  const ClassificationBody({super.key});

  @override
  State<ClassificationBody> createState() => _ClassificationBodyState();
}

class _ClassificationBodyState extends State<ClassificationBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SizedBox(height: 15),
          CameraInputWidget(),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Text('Label Placeholder'),
            ),
          ),
          SizedBox(
            height: 150,
            child: SingleChildScrollView(
              child: Text('Additional Information Placeholder'),
            ),
          ),
          ClassificationButton(),
        ],
      ),
    );
  }
}

class ClassificationButton extends StatelessWidget {
  const ClassificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {}, 
      child: const Text('Start classification'),
    );
  }
}
