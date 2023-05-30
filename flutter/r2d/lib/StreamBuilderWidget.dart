import 'dart:async';

import "package:flutter/material.dart";
import "dart:typed_data";
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget({super.key});

  @override
  State<StreamBuilderWidget> createState() => _StreamBuilderWidgetState();
}

late Uint8List lastImageShown;

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  late StreamController<Uint8List> _controller;
  late IOWebSocketChannel _channel;

  @override
  void initState() {
    super.initState();

    _controller = StreamController<Uint8List>();
    _channel = IOWebSocketChannel.connect('ws://192.168.4.1:8888');

    _channel.stream.listen((dynamic data) {
      if (data is Uint8List) {
        _controller.add(data);
        return;
      }

      print("wrong type");
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Uint8List>(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          List<Widget> children;

          if (snapshot.hasData == false) {
            children = const [
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              Text("There is no data to be displayed"),
            ];
          } else if (snapshot.hasError) {
            children = const [
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              Text("An error occured while loading the data"),
            ];
          } else {
            Uint8List imgData = snapshot.data!;
            lastImageShown = snapshot.data!;

            children = [
              FadeInImage(
                placeholder: Image.memory(lastImageShown).image,
                 image: Image.memory(imgData).image,
              ),
            ];
          }

          return Column(
            children: children,
          );
        });
  }
}
