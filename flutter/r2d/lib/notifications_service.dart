import "dart:async";
import "dart:io";
import "package:notifications/notifications.dart";


class NotificationsService {
  Notifications? _notifications;
  StreamSubscription<NotificationEvent>? _subscription;

  void startListening() {
    _notifications = Notifications();
    try {
      _subscription = _notifications!.notificationStream!.listen(onData);
      print('Notification listening');
    } on NotificationException catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _subscription?.cancel();
    print('Notification not listening');
  }

  void onData(NotificationEvent event) {
    print(event);
  }


}
