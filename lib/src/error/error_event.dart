/// Base error event for the `ProcessBloc`s error stream. May be extended for custom messaging.
class ErrorEvent {
  final String? message;

  ErrorEvent(this.message);
}
