import 'package:flutter/material.dart';
import 'DrawerWidget.dart';

class AudioRecorderWidget extends StatefulWidget {
  const AudioRecorderWidget({Key? key}) : super(key: key);

  @override
  _AudioRecorderWidgetState createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  bool _isRecording = false;
  bool _isPlaying = false;
  int _recordingCount = 1;
  int _selectedRecordingIndex = -1;

  List<String> dummyRecordings = ['Aufnahme 1'];

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
      _isPlaying = false; // Deaktiviere das Abspielen beim Starten der Aufnahme
      if (_isRecording) {
        _selectedRecordingIndex = -1; // Setze die ausgewählte Aufnahme zurück
      }
    });
  }

  void _togglePlaying() {
    setState(() {
      if (_selectedRecordingIndex != -1) {
        _isPlaying = !_isPlaying;
      }
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String recordingName = '';
        return AlertDialog(
          title: Text('Bitte gib einen Namen für die Audioaufnahme ein'),
          content: TextField(
            onChanged: (value) {
              recordingName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Füge neue Aufnahme hinzu
                setState(() {
                  _recordingCount++;
                  dummyRecordings.add(recordingName.isNotEmpty
                      ? recordingName
                      : 'Aufnahme $_recordingCount');
                });
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _selectRecording(int index) {
    setState(() {
      _selectedRecordingIndex = index;
      _isPlaying =
          false; // Deaktiviere das Abspielen beim Auswählen einer Aufnahme
    });
  }

  void _deleteRecording(int index) {
    setState(() {
      dummyRecordings.removeAt(index);
      _selectedRecordingIndex = -1;
      _isPlaying =
          false; // Deaktiviere das Abspielen nach dem Löschen einer Aufnahme
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audiorecording'),
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _toggleRecording();
              if (_isRecording) {
                // Starte Aufnahme
              } else {
                // Stoppe Aufnahme
                _showDialog();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: _isRecording ? Colors.red : null,
              shape: CircleBorder(),
              padding: EdgeInsets.all(30.0),
            ),
            child: Icon(
              _isRecording ? Icons.stop : Icons.mic,
              size: 60.0,
            ),
          ),
          ElevatedButton(
            onPressed: _selectedRecordingIndex != -1 ? _togglePlaying : null,
            style: ElevatedButton.styleFrom(
              primary: _selectedRecordingIndex != -1
                  ? (_isPlaying ? Colors.blue : Colors.green)
                  : Colors.grey,
              shape: CircleBorder(),
              padding: EdgeInsets.all(30.0),
            ),
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              size: 60.0,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dummyRecordings.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(dummyRecordings[index]),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    _deleteRecording(index);
                  },
                  child: ListTile(
                    title: Text(dummyRecordings[index]),
                    tileColor:
                        index == _selectedRecordingIndex ? Colors.blue : null,
                    onTap: () {
                      _selectRecording(index);
                    },
                    // Weitere Eigenschaften und Aktionen für die Aufnahmen
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
