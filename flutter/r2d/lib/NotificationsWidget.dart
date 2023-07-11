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
  bool _isActive = false;

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Text('Notifications'),
            Switch(
              value: _isActive,
              onChanged: (bool value) {
                if (!value) {
                  notificationsService.startListening();
                } else {
                  notificationsService.stopListening();
                }
                setState(() {
                  _isActive = value;
                });
              },
            ),
          ])
        ],
      ),
    );
  }
}
