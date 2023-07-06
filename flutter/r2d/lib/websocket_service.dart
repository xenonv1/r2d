import 'dart:io';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final String _url = 'ws://192.168.137.249:8080';
  Function(dynamic)? onMessageReceived;

  void connect() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_url));
      _channel?.stream.listen(_onMessageReceived);
      print('WebSocket connected');
    } catch (e) {
      print('Failed to connect to WebSocket: $e');
    }
  }


  void disconnect() {
    try {
      _channel?.sink.close();
      print('WebSocket disconnected');
    } catch (e) {
      print('Failed to disconnect from WebSocket: $e');
    }
  }


  void sendMessage(dynamic message) {
    try {
      _channel?.sink.add(message);
      print('Message sent: $message');
    } catch (e) {
      print('Failed to send message: $e');
    }
  }


  void _onMessageReceived(dynamic message) {
    print('Message received: $message');
    if (onMessageReceived != null) {
      onMessageReceived!(message);
    }
  }

}