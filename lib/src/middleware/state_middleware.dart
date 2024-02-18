import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/middleware/middleware.dart';

abstract interface class StateMiddleware<TState extends ProcessBlocState>
    implements Middleware {
  Future<void> onStateChanged(TState state);
}
