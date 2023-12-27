import 'package:bloc_process/src/bloc/process_bloc.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:bloc_process/src/helper/bloc_dependant.dart';

import '../bloc/interfaces/process_bloc_event.dart';
import '../navigation/navigation_handler.dart';
import '../navigation/process_navigator.dart';

class ProcessController<
        TReturn,
        TEvent extends ProcessBlocEvent,
        TState extends ProcessBlocState,
        TBloc extends ProcessBloc<TEvent, TState, TReturn>,
        TNavigator extends ProcessNavigator<TBloc, TState>>
    extends BlocDependant<TBloc> {
  final NavigationHandler _navigationHandler;
  final void Function(TReturn value) _completedCallback;

  ProcessController(
    TBloc bloc,
    TNavigator navigator,
    void Function(TReturn value) completedCallback,
  )   : _navigationHandler = NavigationHandler(navigator, bloc),
        _completedCallback = completedCallback,
        super(bloc) {
    _navigationHandler.mount(bloc.stream);
    bloc.mountCallback(_onComplete);
  }

  void _onComplete(TReturn value) {
    _completedCallback.call(value);

    _close();
  }

  void start() {}

  void _close() {
    _navigationHandler.unmount();

    bloc.close();
  }
}
