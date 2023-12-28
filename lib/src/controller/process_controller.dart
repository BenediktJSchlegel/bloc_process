import 'package:bloc_process/src/bloc/process_bloc.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:bloc_process/src/helper/bloc_dependant.dart';
import 'package:flutter/widgets.dart';

import '../bloc/interfaces/process_bloc_event.dart';
import '../exceptions/process_already_started_error.dart';
import '../navigation/navigation_handler.dart';
import '../navigation/process_navigator.dart';

class ProcessController<
        TInput,
        TEvent extends ProcessBlocEvent,
        TState extends ProcessBlocState,
        TReturn,
        TBloc extends ProcessBloc<TInput, TEvent, TState, TReturn>,
        TNavigator extends ProcessNavigator<TBloc, TState>>
    extends BlocDependant<TBloc> {
  final NavigationHandler _navigationHandler;
  final ProcessNavigator Function(BuildContext context) _navigationBuilder;

  late final void Function(TReturn value) _completedCallback;

  bool hasBeenStarted = false;

  ProcessController({
    required TBloc bloc,
    required ProcessNavigator Function(BuildContext context) navigationBuilder,
  })  : _navigationHandler = NavigationHandler(bloc),
        _navigationBuilder = navigationBuilder,
        super(bloc) {
    bloc.mountCallback(_onComplete);
  }

  void start(BuildContext context, TInput input,
      void Function(TReturn output) callback) {
    if (hasBeenStarted) {
      throw ProcessAlreadyStartedError();
    }

    _completedCallback = callback;
    hasBeenStarted = true;

    bloc.initialize(input);

    _navigationHandler.mount(_navigationBuilder.call(context), bloc.stream);
    _navigationHandler.start();
  }

  void _onComplete(TReturn value) {
    _completedCallback.call(value);

    _close();
  }

  void _close() {
    _navigationHandler.end();
    _navigationHandler.unmount();

    bloc.close();
  }
}
