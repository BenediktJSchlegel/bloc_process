import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/chain/chain_entry.dart';

class ProcessEntry<
    TInput,
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TReturn,
    TBloc extends ProcessBloc<TInput, TEvent, TState, TReturn>,
    TNavigator extends ProcessNavigator<TBloc, TState>,
    TProcess extends ProcessController<TInput, TEvent, TState, TReturn, TBloc,
        TNavigator>> implements ChainEntry<TInput, TReturn> {
  @override
  // TODO: implement onCompleted
  void Function(dynamic output) get onCompleted => throw UnimplementedError();

  @override
  void start(input) {
    // TODO: implement start
  }
}
