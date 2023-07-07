import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class CameraWidget extends StatelessWidget {
  const CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CameraPage();
  }
}

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _showImageStream = false;
  bool _showStaticImage = false;
  bool _showConfirmationPopup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamera'),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_showImageStream) ImageStreamWidget(),
            if (_showStaticImage) StaticImageWidget(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showImageStream = true;
                  _showStaticImage = false;
                });
              },
              child: Text('Live Video'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showImageStream = false;
                  _showStaticImage = true;
                });
              },
              child: Text('Aufgenommenes Bild'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Öffne Einstellungsseite
              },
              child: Text('Kameraeinstellungen'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_showConfirmationPopup) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmationPopup();
              },
            );
          }

          setState(() {
            _showConfirmationPopup = true;
          });
        },
        child: Icon(Icons.camera_alt_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ImageStreamWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.grey,
      child: Center(
        child: Image.asset('assets/images/LiveRecord.png'),
      ),
    );
  }
}

class StaticImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.grey,
      child: Center(
        child: Image.asset('assets/images/Example_Camera.png'),
      ),
    );
  }
}

class ConfirmationPopup extends StatelessWidget {
  const ConfirmationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Aufnahme bestätigt'),
      content: Text('Deine Aufnahme wurde gespeichert'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
