import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class FacialRecognitionWidget extends StatelessWidget {
  const FacialRecognitionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: FacialRecognitionPage(),
      
    );
    
  }
  }

class FacialRecognitionPage extends StatefulWidget {
  @override
  _FacialRecognitionPageState createState() => _FacialRecognitionPageState();
}

class _FacialRecognitionPageState extends State<FacialRecognitionPage> {
  bool isPersonDetected = false;

  void detectPerson() {
    // Platzhalter für die Logik
    setState(() {
      isPersonDetected = true;
    });
  }

  void refreshPage() {
    setState(() {
      isPersonDetected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personenerkennung'),
      ),
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isPersonDetected)
              Column(
                children: [
                  Image.asset(
                    'assets/images/Mustermann.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Max Mustermann',
                     style: TextStyle(fontSize: 32),
                  ),
                ],
              )
            else
              const Column(
                children: [
                  Icon(
                    Icons.face_outlined,
                    size: 200,
                    color: Colors.red,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Keine Person erkannt',
                    style: TextStyle(fontSize: 32),
                  ),
                ],
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: detectPerson,
              child: const Text(
                'Gesicht erkennen',
                style: TextStyle(fontSize: 24)),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: refreshPage,
              child: const Text('Aktualisieren',
              style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}
