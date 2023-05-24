import "dart:io";

import "package:r2d/StreamWidget.dart";

class Server {
  void startServer() {
    VideoStreamWidgetState streamWidget = VideoStreamWidgetState();

    const url = "192.168.43.111";
    const port = 8080;

    HttpServer.bind(url, port).then((server) {
      print('Listening on ${server.address}:${server.port}.');

      server.listen((HttpRequest req) {
        if (WebSocketTransformer.isUpgradeRequest(req)) {
          WebSocketTransformer.upgrade(req).then((WebSocket webSocket) {
            webSocket.listen((dynamic message) {
              print(message.runtimeType);
              streamWidget.setImage(message);
            });
          });
        } else {
          // handle http requests
        }
      }); //server.listen
    }); //HttpServer.bind
  }
}
