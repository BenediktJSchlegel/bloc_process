import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/bloc/process_bloc.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:bloc_process/src/helper/bloc_dependant.dart';
import 'package:flutter/widgets.dart';

import '../bloc/interfaces/process_bloc_event.dart';
import '../exceptions/process_already_completed_error.dart';
import '../exceptions/process_already_started_error.dart';
import '../exceptions/process_not_started_error.dart';
import '../navigation/navigation_handler.dart';
import '../navigation/process_navigator.dart';

/// Main entrypoint for the `BlocProcess`.
///
/// ---
///
/// `TInput`: the type for the process input
///
/// `TEvent` of Type `ProcessBlocEvent`: the type of the event classes
///
/// `TState` of Type `ProcessBlocState`: the type of the state object
///
/// `TOutput`: the type of the process output
///
/// `TBloc` of type `ProcessBloc`: type of the bloc controlling this process
///
/// `TNavigator` of type `ProcessNavigator`: type of the navigator responsible for this process
///
/// ---
///
/// This class  may be extended to abstract away the many type declarations
class ProcessController<
    TInput,
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TOutput,
    TBloc extends ProcessBloc<TInput, TEvent, TState, TOutput>,
    TNavigator extends ProcessNavigator<TBloc, TState>> extends BlocDependant<TBloc> {
  final NavigationHandler _navigationHandler;
  final ProcessNavigator Function(BuildContext context) _navigationBuilder;

  late final Future<void> Function(TOutput value) _completedCallback;
  late final Future<void> Function()? _backOutCallback;

  final bool _persistAfterCompletion;

  bool _hasBeenStarted = false;
  bool _allowRestart = false;

  ProcessController({
    required TBloc bloc,
    required ProcessNavigator Function(BuildContext context) navigationBuilder,
    NavigationConfiguration navigationConfiguration = const NavigationConfiguration.defaultConfiguration(),
    bool persistAfterCompletion = false,
  })  : _navigationHandler = NavigationHandler(bloc, navigationConfiguration),
        _navigationBuilder = navigationBuilder,
        _persistAfterCompletion = persistAfterCompletion,
        super(bloc) {
    bloc.mountCallbacks(_onComplete, _onBackOut);
  }

  /// Starts the process using the provided [context] and [input]. The output [callback] will be called once the process completes.
  ///
  /// This may only be called once per process.
  /// Calling this more than once will cause a `ProcessAlreadyStartedError` to be thrown.
  void start(
    BuildContext context,
    TInput input,
    Future<void> Function(TOutput output) callback, [
    Future<void> Function()? backOut,
  ]) {
    if (_hasBeenStarted && !_allowRestart) {
      throw ProcessAlreadyStartedError();
    }

    if (!_hasBeenStarted) {
      _completedCallback = callback;
      _backOutCallback = backOut;
      _hasBeenStarted = true;

      _navigationHandler.init(_navigationBuilder.call(context));
    }

    _navigationHandler.mount(bloc.stream);

    bloc.initialize(input);

    _navigationHandler.start();
  }

  /// Restarts a process that has previously been finished, retaining the state from before.
  /// This calls the `revive()` method in the `TNavigator`
  void revive() async {
    if (!_hasBeenStarted) {
      throw ProcessNotStartedError();
    }

    if (!_persistAfterCompletion) {
      throw ProcessAlreadyCompletedError();
    }

    await _navigationHandler.revive();
  }

  /// fully closes the process, even if `persistAfterCompletion` is true.
  void fullyClose() {
    _closeDependencies();
  }

  /// prematurely terminates the process using the given `output`
  Future<void> cancel(TOutput output) async {
    await _onComplete(output);
  }

  /// prematurely terminates the process without calling the `completedCallback`
  Future<void> cancelWithoutOutput() async {
    await _close();
  }

  Future<void> _onBackOut() async {
    await _navigationHandler.end();
    _navigationHandler.unmount();

    _allowRestart = true;

    _backOutCallback?.call();
  }

  Future<void> _onComplete(TOutput value) async {
    await _close();

    await _completedCallback.call(value);
  }

  Future<void> _close() async {
    await _navigationHandler.end();

    if (!_persistAfterCompletion) {
      _closeDependencies();
    }
  }

  void _closeDependencies() {
    _allowRestart = false;
    _navigationHandler.unmount();

    bloc.close();
  }

  bool isStarted() => _hasBeenStarted;
}
