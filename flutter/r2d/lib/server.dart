import "dart:io";

import "package:r2d/StreamWidget.dart";

class Server {

  void startServer() {
    StreamWidgetState streamWidget = StreamWidgetState();

    String url = "127.0.0.1";
    const port = 8080;

    HttpServer.bind(url, port).then((server) {
      print('Listening on ${server.address}:${server.port}.');

      server.listen((HttpRequest req) {
        if (WebSocketTransformer.isUpgradeRequest(req)) {
          WebSocketTransformer.upgrade(req).then((WebSocket webSocket) {
            webSocket.listen((dynamic message) {
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
