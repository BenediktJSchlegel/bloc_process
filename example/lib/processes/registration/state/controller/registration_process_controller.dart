import 'package:bloc_process/bloc_process.dart';

import '../bloc/registration_process_bloc.dart';
import '../bloc/registration_process_events.dart';
import '../bloc/registration_process_state.dart';
import '../navigation/registration_process_navigator.dart';
import '../result/registration_process_result.dart';

class RegistrationProcessController extends ProcessController<
    String,
    RegistrationProcessEvent,
    RegistrationProcessState,
    RegistrationProcessResult,
    RegistrationProcessBloc,
    RegistrationProcessNavigator> {
  RegistrationProcessController({
    required super.bloc,
    required super.navigationBuilder,
  });
}
