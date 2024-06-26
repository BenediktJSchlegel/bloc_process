import 'package:bloc_process/bloc_process.dart';

/// abstract class that defines a `ProcessNavigator` for a `BlocProcess`
///
/// Must declare [TBloc] which is the type of the `ProcessBloc` and [TState], the type of the state object.
abstract class ProcessNavigator<TBloc extends ProcessBloc, TState extends ProcessBlocState> {
  /// gets called when any new [state] is emitted by the bloc
  Future<void> onStateChanged(TBloc bloc, TState state);

  /// gets called when the process is initially started
  Future<void> onStart(TBloc bloc);

  /// gets called when `complete()` is called inside the bloc
  Future<void> onEnd(TBloc bloc);

  /// gets called when get process gets revived
  Future<void> onRevive(TBloc bloc);
}
