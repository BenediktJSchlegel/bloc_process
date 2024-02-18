import 'package:bloc_process/bloc_process.dart';

abstract interface class StateMiddleware<TState extends ProcessBlocState>
    implements Middleware {
  Future<void> onStateChanged(TState state);
}
