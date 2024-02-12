import 'package:bloc/src/bloc.dart';
import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/multi/state/bloc/multi_bloc.dart';
import 'package:example/processes/multi/state/bloc/state/multi_state.dart';
import 'package:example/processes/multi/state/io/multi_output.dart';

import '../events/first_multi_event.dart';

class FirstChannel extends BlocChannel<FirstMultiEvent, MultiState, MultiBloc> {
  FirstChannel(super.bloc);

  @override
  Future<void> onEvent(FirstMultiEvent event, Emitter<MultiState> emit) async {
    emit(MultiState("First"));

    switch (event.runtimeType) {
      case CanceledEvent:
        bloc.complete(MultiOutput());
        break;
      default:
        break;
    }
  }
}
