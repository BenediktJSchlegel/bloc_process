import 'package:bloc_process/bloc_process.dart';

import '../bloc/registration_process_bloc.dart';
import '../bloc/registration_process_events.dart';
import '../bloc/registration_process_state.dart';
import '../controller/registration_process_controller.dart';
import '../navigation/registration_process_navigator.dart';
import '../result/registration_process_result.dart';

class RegistrationLink extends ProcessLink<
    String,
    RegistrationProcessEvent,
    RegistrationProcessState,
    RegistrationProcessResult,
    RegistrationProcessBloc,
    RegistrationProcessNavigator,
    RegistrationProcessController> {
  RegistrationLink(
    super.controller, {
    required super.inputTransformer,
    required super.outputTransformer,
  });
}
