import 'package:bloc_process/src/bloc/error_producing_bloc.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_event.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';

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
abstract class ProcessBloc<
    TInput,
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TOutput> extends ErrorProducingBloc<TEvent, TState, TOutput> {
  ProcessBloc(super.initialState);

  /// called when `ProcessController.start()` gets called. [input] corresponds to the input to said method.
  initialize(TInput input);
}
