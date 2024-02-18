import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/effects/effect.dart';
import 'package:bloc_process/src/middleware/middleware.dart';

abstract interface class EventMiddleware<TEvent extends ProcessBlocEvent>
    implements Middleware {
  Future<void> onEvent(TEvent event);
}
