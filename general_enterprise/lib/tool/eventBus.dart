import 'package:event_bus/event_bus.dart';

class EventBusUtils {
  static EventBus _instance;

  static EventBus getInstance() {
    if (null == _instance) {
      _instance = new EventBus();
    }
    return _instance;
  }
}

class ChatEvent {
  Map<dynamic, dynamic> message;
  ChatEvent(this.message);
}

class NotifiThing {
  List list;
  NotifiThing(this.list);
}

class FireRefrsh {
  final bool invoke;
  FireRefrsh(this.invoke);
}
