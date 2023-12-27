import 'package:bloc_process/bloc_process.dart';
import 'package:example/state/bloc/registration_process_events.dart';
import 'package:example/state/bloc/registration_process_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../result/registration_process_result.dart';

class RegistrationProcessBloc extends ProcessBloc<RegistrationProcessEvent,
    RegistrationProcessState, RegistrationProcessResult> {
  RegistrationProcessBloc() : super(RegistrationProcessState.initial()) {
    on((RegistrationProcessEvent event,
        Emitter<RegistrationProcessState> emit) {});
  }
}
