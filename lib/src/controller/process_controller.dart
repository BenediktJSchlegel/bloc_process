import 'package:bloc_process/src/bloc/process_bloc.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:bloc_process/src/helper/bloc_dependant.dart';
import 'package:flutter/widgets.dart';

import '../bloc/interfaces/process_bloc_event.dart';
import '../exceptions/process_already_started_error.dart';
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
        TNavigator extends ProcessNavigator<TBloc, TState>>
    extends BlocDependant<TBloc> {
  final NavigationHandler _navigationHandler;
  final ProcessNavigator Function(BuildContext context) _navigationBuilder;

  late final void Function(TOutput value) _completedCallback;

  bool _hasBeenStarted = false;

  ProcessController({
    required TBloc bloc,
    required ProcessNavigator Function(BuildContext context) navigationBuilder,
  })  : _navigationHandler = NavigationHandler(bloc),
        _navigationBuilder = navigationBuilder,
        super(bloc) {
    bloc.mountCallback(_onComplete);
  }

  /// Starts the process using the provided [context] and [input]. The output [callback] will be called once the process completes.
  ///
  /// This may only be called once per process.
  /// Calling this more than once will cause a `ProcessAlreadyStartedError` to be thrown.
  void start(
    BuildContext context,
    TInput input,
    void Function(TOutput output) callback,
  ) {
    if (_hasBeenStarted) {
      throw ProcessAlreadyStartedError();
    }

    _completedCallback = callback;
    _hasBeenStarted = true;

    bloc.initialize(input);

    _navigationHandler.mount(_navigationBuilder.call(context), bloc.stream);
    _navigationHandler.start();
  }

  void _onComplete(TOutput value) {
    _close();

    _completedCallback.call(value);
  }

  void _close() {
    _navigationHandler.end();
    _navigationHandler.unmount();

    bloc.close();
  }
}
