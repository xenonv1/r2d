import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:r2d/notifications_service.dart';
import 'DrawerWidget.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Funktionseinstellungen")),
      drawer: DrawerWidget(),
      body: NotificationsPage(),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final notificationsService = NotificationsService();
  bool _switchvalue1 = false;
  bool _switchvalue2 = false;
  bool _switchvalue3 = false;
  bool _switchvalue4 = false;
  bool _switchvalue5 = false;
  bool _switchvalue6 = false;
  bool _switchvalue7 = false;

  @override
  void initState() {
    super.initState();
    //notificationsService = _onMessageReceived;
  }

  @override
  void dispose() {
    notificationsService.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(children: [
            const Icon(Icons.notifications),
            const Spacer(flex: 1),
            const Text('Benachrichtigungen',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 12),
            Switch(
              value: _switchvalue1,
              onChanged: (bool value) {
                if (!value) {
                  notificationsService.startListening();
                } else {
                  notificationsService.stopListening();
                }
                setState(() {
                  _switchvalue1 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Text('Uhrzeit',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 1),
            Switch(
              value: _switchvalue2,
              onChanged: (bool value) {
                if (!value) {
                  notificationsService.startListening();
                } else {
                  notificationsService.stopListening();
                }
                setState(() {
                  _switchvalue2 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Text('Datum',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 1),
            Switch(
              value: _switchvalue3,
              onChanged: (bool value) {
                if (!value) {
                  notificationsService.startListening();
                } else {
                  notificationsService.stopListening();
                }
                setState(() {
                  _switchvalue3 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Text('Akkustand',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 1),
            Switch(
              value: _switchvalue4,
              onChanged: (bool value) {
                if (!value) {
                  notificationsService.startListening();
                } else {
                  notificationsService.stopListening();
                }
                setState(() {
                  _switchvalue4 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Text('Anrufe',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 1),
            Switch(
              value: _switchvalue5,
              onChanged: (bool value) {
                if (!value) {
                  notificationsService.startListening();
                } else {
                  notificationsService.stopListening();
                }
                setState(() {
                  _switchvalue5 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Text('Wetter',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 1),
            Switch(
              value: _switchvalue6,
              onChanged: (bool value) {
                if (!value) {
                  notificationsService.startListening();
                } else {
                  notificationsService.stopListening();
                }
                setState(() {
                  _switchvalue6 = value;
                });
              },
            ),
          ]),
          Row(children: [
            const Text('Notsignal',
                style: TextStyle(
                  fontSize: 16,
                )),
            const Spacer(flex: 1),
            Switch(
              value: _switchvalue7,
              onChanged: (bool value) {
                if (!value) {
                  notificationsService.startListening();
                } else {
                  notificationsService.stopListening();
                }
                setState(() {
                  _switchvalue7 = value;
                });
              },
            ),
          ]),
        ],
      ),
    );
  }
}
