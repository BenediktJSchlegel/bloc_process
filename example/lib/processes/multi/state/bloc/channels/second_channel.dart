import 'package:bloc/src/bloc.dart';
import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/multi/state/bloc/events/second_multi_event.dart';
import 'package:example/processes/multi/state/bloc/state/multi_state.dart';

import '../multi_bloc.dart';

class SecondChannel
    extends BlocChannel<SecondMultiEvent, MultiState, MultiBloc> {
  SecondChannel(super.bloc);

  @override
  Future<void> onEvent(SecondMultiEvent event, Emitter<MultiState> emit) async {
    emit(MultiState("Second"));
  }
}
