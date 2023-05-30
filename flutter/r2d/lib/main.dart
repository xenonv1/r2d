import 'package:flutter/material.dart';

import 'server.dart';
import 'StreamWidget.dart';
import "StreamBuilderWidget.dart";

void main() {
  // start the websocket server when the app is launched (no need for second version)
  Server server = Server();
  server.startServer();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'R2D App',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'R2D App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            //StreamBuilderWidget(),
            VideoStreamWidget(), 
          ],
        ),
      ),
    );
  }
}
