import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class CameraWidget extends StatelessWidget {
  const CameraWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamera'),
      ),
      drawer: const DrawerWidget(),
      body: const CameraPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const ConfirmationPopup(),
          );
        },
        child: const Icon(Icons.camera_alt_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage();

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  int _imageType = 0;
  bool _showConfirmationPopup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageWidget(imageType: _imageType),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _imageType = 0;
                });
              },
              child: const Text('Live Video'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _imageType = 1;
                });
              },
              child: const Text('Aufgenommenes Bild'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Öffne Einstellungsseite
              },
              child: const Text('Kameraeinstellungen'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final int imageType;

  const ImageWidget({required this.imageType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.grey,
      child: Center(
        child: Image.asset(
          imageType == 0 ? 'assets/images/LiveRecord.png' : 'assets/images/Example_Camera.png',
        ),
      ),
    );
  }
}

class ConfirmationPopup extends StatelessWidget {
  const ConfirmationPopup({Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Aufnahme bestätigt'),
      content: const Text('Deine Aufnahme wurde gespeichert'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}