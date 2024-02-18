import 'package:bloc_process/bloc_process.dart';

abstract interface class EventMiddleware<TEvent extends ProcessBlocEvent>
    implements Middleware {
  Future<void> onEvent(TEvent event);
}
