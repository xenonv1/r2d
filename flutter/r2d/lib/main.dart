import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'server.dart';
// import 'StreamWidget.dart';
import 'DrawerWidget.dart';
import 'ObjectClassificationWidget.dart';
import 'AudioRecorderWidget.dart';
import 'CameraWidget.dart';
import 'TextRecognitionWidget.dart';

void main() {
  // start the websocket server when the app is launched (no need for second version)
  Server server = Server();
  server.startServer();

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MyHomePage(title: 'R2D-App');
        }),
    GoRoute(
        path: '/object-classification',
        builder: (BuildContext context, GoRouterState state) {
          return const ObjectClassificationWidget();
        }),
    GoRoute(
        path: '/audio-recorder',
        builder: (BuildContext context, GoRouterState state) {
          return const AudioRecorderWidget();
        }),
    GoRoute(
        path: '/camera',
        builder: (BuildContext context, GoRouterState state) {
          return const CameraWidget();
        }),
    GoRoute(
        path: '/ocr',
        builder: (BuildContext context, GoRouterState state) {
          return const TextRecognitionWidget();
        }),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'R2D App',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
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
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center
        ),
      ),
    );
  }
}
