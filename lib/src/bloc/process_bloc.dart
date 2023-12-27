import 'package:bloc_process/src/bloc/error_producing_bloc.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_event.dart';
import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';

abstract class ProcessBloc<
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TReturn> extends ErrorProducingBloc<TEvent, TState, TReturn> {
  ProcessBloc(super.initialState);
}
