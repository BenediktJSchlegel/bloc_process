import 'package:bloc_process/bloc_process.dart';
import 'package:example/state/bloc/registration_process_events.dart';
import 'package:example/state/bloc/registration_process_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../result/registration_process_result.dart';

class RegistrationProcessBloc extends ProcessBloc<
    String,
    RegistrationProcessEvent,
    RegistrationProcessState,
    RegistrationProcessResult> {
  RegistrationProcessBloc() : super(RegistrationProcessState.initial()) {
    on((RegistrationProcessEvent event,
        Emitter<RegistrationProcessState> emit) {
      switch (event.runtimeType) {
        case BasicInformationSubmittedEvent:
          emit(RegistrationProcessState(
              RegistrationProcessPages.regionSelection, state.role));
          break;
        case RegionSelectionSubmittedEvent:
          emit(RegistrationProcessState(
              RegistrationProcessPages.password, state.role));
          break;
        case PasswordSubmittedEvent:
          complete(RegistrationProcessResult(state.role));
          break;
        case ThrowErrorEvent:
          emitError(ErrorEvent((event as ThrowErrorEvent).message));
          break;
        case UserRoleChangedEvent:
          _onUserRoleChanged(event as UserRoleChangedEvent, emit);
          break;
      }
    });
  }

  void _onUserRoleChanged(
      UserRoleChangedEvent event, Emitter<RegistrationProcessState> emit) {
    emit(RegistrationProcessState(state.page, event.role));
  }

  @override
  initialize(String input) {
    print(input);
  }
}
