import "package:flutter/material.dart";
import "dart:typed_data";
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget({super.key});

  @override
  State<StreamBuilderWidget> createState() => _StreamBuilderWidgetState();
}

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Uint8List>(
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
      List<Widget> children;

      if (!snapshot.hasData) {
        children = const [
          Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          Text("There is no data to be displayed"),
        ];
      } else if (!snapshot.hasError) {
        children = const [
          Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          Text("An error occured while loading the data"),
        ];
      } else {
        Uint8List imgData = snapshot.data!;

        children = [
          Image.memory(imgData),
        ];
      }

      return Column(
        children: children,
      );
    });
  }
}
