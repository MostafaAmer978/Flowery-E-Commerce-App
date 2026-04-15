sealed class TrackingEvent {}

class GetDataEvent extends TrackingEvent {
  String orderId;

  GetDataEvent(this.orderId);
}

class StreamDriverLocationEvent extends TrackingEvent {
  String orderId;

  StreamDriverLocationEvent(this.orderId);
}

class CallDriverEvent extends TrackingEvent {
  String phoneNumber;
  CallDriverEvent(this.phoneNumber);
}

class WatsappDriverEvent extends TrackingEvent {
  String phoneNumber;
  String message;
  WatsappDriverEvent(this.phoneNumber, {this.message = ""});
}
