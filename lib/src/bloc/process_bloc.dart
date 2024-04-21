import 'package:bloc_process/src/bloc/busy_setting_bloc.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_event.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:flutter/cupertino.dart';

/// abstract class for the `ProcessBloc` which controls the `BlocProcess`.
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
abstract class ProcessBloc<TInput, TEvent extends ProcessBlocEvent, TState extends ProcessBlocState, TOutput>
    extends BusySettingBloc<TEvent, TState, TOutput> {
  ProcessBloc(super.initialState);

  /// Called when `ProcessController.start()` gets called. [input] corresponds to the input to said method.
  initialize(TInput input);

  @override
  @mustCallSuper
  void add(TEvent event) {
    eventMiddleware?.forEach((middleware) {
      middleware.onEvent(event);
    });

    super.add(event);
  }

  /// Called when the process starts, and the `NavigationBehaviour` of the
  /// `NavigationConfiguration` is set to `NavigationBehaviour.callback`
  bool shouldNavigationOnStart() {
    return true;
  }

  /// Called when the process ends, and the `NavigationBehaviour` of the
  /// `NavigationConfiguration` is set to `NavigationBehaviour.callback`
  bool shouldNavigationOnEnd() {
    return true;
  }

  /// Called when the process gets revived, and the `NavigationBehaviour` of the
  /// `NavigationConfiguration` is set to `NavigationBehaviour.callback`
  bool shouldNavigationOnRevive() {
    return true;
  }
}
